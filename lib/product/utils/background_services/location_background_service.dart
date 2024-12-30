import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:marti_location_tracking/product/enum/tracking_status_enum.dart';
import 'package:marti_location_tracking/product/utils/cache_functions/location_store_function.dart';

class LocationBackgroundService {
  LocationBackgroundService._init();
  static final LocationBackgroundService _instance = LocationBackgroundService._init();
  static LocationBackgroundService get instance => _instance;
  void startBackground(
      {required TrackingStatusEnum trackingStatus,
      required Set<Marker> markers,
      required List<LatLng> polylineCoordinatesList,
      required LocationData? lastMarkerPosition}) {
    if (trackingStatus == TrackingStatusEnum.STOPED || trackingStatus == TrackingStatusEnum.STARTED_PAUSED) return;
    final locationCacheOperationBackground = LocationStoreFunction.instance;
    final backgroundMarkers = markers;
    final backgroundPolylineCoordinatesList = polylineCoordinatesList;

    trackingStatus = TrackingStatusEnum.BACKGROUND;
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      final latitude = location.coords.latitude;
      final longitude = location.coords.longitude;
      if (lastMarkerPosition?.longitude != null && lastMarkerPosition?.latitude != null) {
        final distance = (geolocator.GeolocatorPlatform.instance
            .distanceBetween(lastMarkerPosition!.latitude!, lastMarkerPosition!.longitude!, latitude, longitude));
        if (distance > 90) {
          final markerId = MarkerId(((backgroundMarkers.length) + 1).toString());
          final marker = Marker(
            markerId: markerId,
            position: LatLng(latitude, longitude),
          );
          backgroundMarkers.add(marker);
          backgroundPolylineCoordinatesList.add(LatLng(latitude, longitude));
          lastMarkerPosition = LocationData.fromMap({
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
        lastMarkerPosition = LocationData.fromMap({
          'latitude': latitude,
          'longitude': longitude,
        });
        locationCacheOperationBackground.updateUnfinishedLocation(
            isFinished: false, markers: backgroundMarkers, polylines: backgroundPolylineCoordinatesList);
      }
    });

    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {});

    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {});

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

  Future<void> stopTrackingBackground(Future<void> Function() onStop) async {
    bg.BackgroundGeolocation.stop();
    await onStop.call();
  }
}
