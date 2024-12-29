import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:marti_location_tracking/product/utils/cache_functions/location_store_function.dart';

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
  LocationData? lastMarkerPosition;
  bool trackingStarted = false;
  final _locationCacheOperation = LocationStoreFunction.instance;
  Future<void> init() async {
    await Future.wait([_setInitialCameraPosition(), getUnfinished()]);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> reset() async {
    trackingStarted = false;
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

  void addMarker(LatLng position, String address) {
    final marker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
    );
    markers.add(marker);
    _locationCacheOperation.updateUnfinishedLocation(isFinished: false, markers: markers, polylines: polylineCoordinatesList);
  }

  Future<void> getUnfinished() async {
    final locationStoreResponseModel = await _locationCacheOperation.getUnfinishedRoute();
    if (locationStoreResponseModel?.isFinished == false) {
      markers = locationStoreResponseModel!.markers ?? {};
      polylineCoordinatesList.addAll(locationStoreResponseModel.polylines ?? []);
      trackingStarted = true;
    }
  }
}
