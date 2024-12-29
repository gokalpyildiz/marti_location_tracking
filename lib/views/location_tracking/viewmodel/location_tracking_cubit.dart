import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:marti_location_tracking/product/enum/tracking_status_enum.dart';
import 'package:marti_location_tracking/product/utils/cache_functions/location_store_function.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;

part 'location_tracking_state.dart';

class LocationTrackingCubit extends Cubit<LocationTrackingState> {
  LocationTrackingCubit() : super(LocationTrackingState()) {
    init();
  }
  LatLng initialcameraposition = LatLng(41.015137, 28.979530);
  final _location = Location();
  Set<Marker> markers = {};

  final List<LatLng> polylineCoordinatesList = [];
  LocationData? currentPosition;
  //Used to measure the distance between the last added marker and the current location
  LocationData? lastMarkerPosition;
  TrackingStatusEnum trackingStatus = TrackingStatusEnum.STOPED;
  final _locationCacheOperation = LocationStoreFunction.instance;
  Future<void> init() async {
    await Future.wait([_setInitialCameraPosition(), getOngoingActivity()]);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> resetDatas() async {
    trackingStatus = TrackingStatusEnum.STOPED;
    polylineCoordinatesList.clear();
    markers.clear();
    lastMarkerPosition = null;
    await _locationCacheOperation.deleteUnfinishedRoute();
  }

  Future<void> _setInitialCameraPosition() async {
    var currentPosition = await _location.getLocation();
    initialcameraposition = LatLng(currentPosition.latitude!, currentPosition.longitude!);
  }

  double calculateDistance({required double startLat, required double startLong, required double endLat, required double endLong}) {
    final distance = (geolocator.GeolocatorPlatform.instance.distanceBetween(startLat, startLong, endLat, endLong));
    return distance;
  }

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

  Future<void> stopTrackingBackground() async {
    await getOngoingActivity();
    if (trackingStatus == TrackingStatusEnum.BACKGROUND) {
      trackingStatus = TrackingStatusEnum.STARTED_CONTINUE;
      bg.BackgroundGeolocation.stop();
    }
  }

  void startBackground() {
    final locationCacheOperationBackground = LocationStoreFunction.instance;
    final backgroundMarkers = markers;
    final backgroundPolylineCoordinatesList = polylineCoordinatesList;
    LocationData? lastMarkerPositionBackground = lastMarkerPosition;
    trackingStatus = TrackingStatusEnum.BACKGROUND;
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      final latitude = location.coords.latitude;
      final longitude = location.coords.longitude;
      if (lastMarkerPosition?.longitude != null && lastMarkerPosition?.latitude != null) {
        final distance = (geolocator.GeolocatorPlatform.instance
            .distanceBetween(lastMarkerPositionBackground!.latitude!, lastMarkerPositionBackground!.longitude!, latitude, longitude));
        print('distance: $distance');
        if (distance > 90) {
          final markerId = MarkerId(((backgroundMarkers.length) + 1).toString());
          final marker = Marker(
            markerId: markerId,
            position: LatLng(latitude, longitude),
          );
          backgroundMarkers.add(marker);
          backgroundPolylineCoordinatesList.add(LatLng(latitude, longitude));
          lastMarkerPositionBackground = LocationData.fromMap({
            'latitude': latitude,
            'longitude': longitude,
          });
          locationCacheOperationBackground.updateUnfinishedLocation(
              isFinished: false, markers: backgroundMarkers, polylines: backgroundPolylineCoordinatesList);
        }
      } else {
        final markerId = MarkerId(((backgroundMarkers.length) + 1).toString());
        final marker = Marker(
          markerId: markerId,
          position: LatLng(latitude, longitude),
        );
        backgroundMarkers.add(marker);
        backgroundPolylineCoordinatesList.add(LatLng(latitude, longitude));
        lastMarkerPositionBackground = LocationData.fromMap({
          'latitude': latitude,
          'longitude': longitude,
        });
        locationCacheOperationBackground.updateUnfinishedLocation(
            isFinished: false, markers: backgroundMarkers, polylines: backgroundPolylineCoordinatesList);
      }
    });

    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
      print('[motionchange] - ${location.coords.latitude}, ${location.coords.latitude}');
    });

    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      print('[providerchange] - $event');
    });

    ////
    // 2.  Configure the plugin
    //
    bg.BackgroundGeolocation.ready(bg.Config(
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter: 10.0,
            stopOnTerminate: false,
            startOnBoot: true,
            debug: true,
            logLevel: bg.Config.LOG_LEVEL_VERBOSE))
        .then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.start();
      }
    });
  }

  Future<void> completeActivity() async {
    await _locationCacheOperation.addFinishedLocation(markers: markers, polylines: polylineCoordinatesList);
    resetDatas();
    emit(state.copyWith(showPausedButtons: false));
  }

  void restartActivity() async {
    resetDatas();
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
        emit(state.copyWith(showPausedButtons: true));
      case TrackingStatusEnum.STARTED_CONTINUE:
        trackingStatus = TrackingStatusEnum.STARTED_PAUSED;
        emit(state.copyWith(showPausedButtons: true));
      case TrackingStatusEnum.BACKGROUND:
        break;
    }
  }
}
