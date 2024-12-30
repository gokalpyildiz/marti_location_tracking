import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:marti_location_tracking/product/enum/tracking_status_enum.dart';
import 'package:marti_location_tracking/product/utils/background_services/base/ILocationBackgroundService.dart';
import 'package:marti_location_tracking/product/utils/background_services/location_background_service.dart';
import 'package:marti_location_tracking/product/utils/cache_functions/location_store_function.dart';

part 'location_tracking_state.dart';

class LocationTrackingCubit extends Cubit<LocationTrackingState> {
  LocationTrackingCubit({required LocationStoreFunction locationCacheOperation}) : super(LocationTrackingState()) {
    _locationCacheOperation = locationCacheOperation;
    init();
  }
  late IBackgroundService _locationBackgroundService;
  LatLng initialcameraposition = LatLng(41.015137, 28.979530);
  final _location = Location();
  Set<Marker> markers = {};
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  final List<LatLng> polylineCoordinatesList = [];
  LocationData? currentPosition;
  //Used to measure the distance between the last added marker and the current location
  LocationData? lastMarkerPosition;
  TrackingStatusEnum trackingStatus = TrackingStatusEnum.STOPED;
  late LocationStoreFunction _locationCacheOperation;
  Future<void> init() async {
    _locationBackgroundService = LocationBackgroundService.instance;
    await Future.wait([_setInitialCameraPosition(), getOngoingActivity()]);
    emit(state.copyWith(isLoading: false));
  }

  //reset tracking information
  Future<void> resetDatas() async {
    trackingStatus = TrackingStatusEnum.STOPED;
    polylineCoordinatesList.clear();
    markers.clear();
    lastMarkerPosition = null;
    await _locationCacheOperation.deleteUnfinishedRoute();
  }

  //used to show the user's location
  Future<void> _setInitialCameraPosition() async {
    var currentPosition = await _location.getLocation();
    initialcameraposition = LatLng(currentPosition.latitude!, currentPosition.longitude!);
  }

  //Used to add a marker every 100 meters
  double calculateDistance({required double startLat, required double startLong, required double endLat, required double endLong}) {
    final distance = (geolocator.GeolocatorPlatform.instance.distanceBetween(startLat, startLong, endLat, endLong));
    return distance;
  }

  //Adds markers
  void addMarker(LatLng position) {
    if (position.latitude == 0 && position.longitude == 0) return;
    final markerId = MarkerId(((markers.length) + 1).toString());
    final marker = Marker(
      markerId: markerId,
      position: position,
      onTap: () {
        emit(state.copyWith(selectedMarkerLatitude: position.latitude, selectedMarkerLongitude: position.longitude));
      },
    );
    markers.add(marker);
    _locationCacheOperation.updateUnfinishedLocation(isFinished: false, markers: markers, polylines: polylineCoordinatesList);
  }

  //devam eden aktiviteyi depolama alanından alma
  Future<void> getOngoingActivity() async {
    final locationStoreResponseModel = await _locationCacheOperation.getUnfinishedRoute(
      (double latitude, double longitude) async {
        emit(state.copyWith(selectedMarkerLatitude: latitude, selectedMarkerLongitude: longitude));
      },
    );
    if (locationStoreResponseModel?.isFinished == false) {
      markers.clear();
      polylineCoordinatesList.clear();
      markers = locationStoreResponseModel!.markers ?? {};
      polylineCoordinatesList.addAll(locationStoreResponseModel.polylines ?? []);

      trackingStatus = TrackingStatusEnum.STARTED_CONTINUE;
    }
  }

  //Background tracking is stopped. It is allowed to continue in the foreground.
  Future<void> stopTrackingBackground() async {
    _locationBackgroundService.stopTrackingBackground(
      () async {
        await getOngoingActivity();
        if (trackingStatus == TrackingStatusEnum.BACKGROUND) {
          trackingStatus = TrackingStatusEnum.STARTED_CONTINUE;
        }
      },
    );
  }

  void startBackground() {
    _locationBackgroundService.startBackground(
      trackingStatus: trackingStatus,
      markers: markers,
      polylineCoordinatesList: polylineCoordinatesList,
      lastMarkerPosition: lastMarkerPosition,
    );
  }

  Future<void> completeActivity() async {
    final controller = await mapController.future;
    final imageBytes = await controller.takeSnapshot();
    final lastPoint = polylineCoordinatesList.last;
    addMarker(lastPoint);
    await _locationCacheOperation.addFinishedLocation(markers: markers, polylines: polylineCoordinatesList, image: imageBytes);
    resetDatas();
    emit(state.copyWith(showPausedButtons: false));
  }

  Future<void> restartActivity() async {
    await resetDatas();
    trackingStatus = TrackingStatusEnum.STARTED_CONTINUE;
    emit(state.copyWith(showPausedButtons: false));
  }

  void resumeActivity() {
    trackingStatus = TrackingStatusEnum.STARTED_CONTINUE;
    emit(state.copyWith(showPausedButtons: false));
  }

  void clearSelectedMarker() {
    emit(state.copyWith(selectedMarkerLatitude: 0, selectedMarkerLongitude: 0));
  }

  void showPausedButtons() {
    switch (trackingStatus) {
      case TrackingStatusEnum.STOPED:
        resumeActivity();
        break;
      case TrackingStatusEnum.STARTED_PAUSED:
        resumeActivity();
      case TrackingStatusEnum.STARTED_CONTINUE:
        trackingStatus = TrackingStatusEnum.STARTED_PAUSED;
        emit(state.copyWith(showPausedButtons: true));
      case TrackingStatusEnum.BACKGROUND:
        break;
    }
  }
}
