import 'dart:async';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:marti_location_tracking/product/enum/tracking_status_enum.dart';
import 'package:marti_location_tracking/product/state/container/product_state_items.dart';
import 'package:marti_location_tracking/product/utils/background_services/base/ILocationBackgroundService.dart';
import 'package:marti_location_tracking/product/utils/cache_functions/location_store_function.dart';
import 'package:geolocator/geolocator.dart' as geolocator;

class BackgroundFetchService implements IBackgroundService {
  BackgroundFetchService._init();
  static final BackgroundFetchService _instance = BackgroundFetchService._init();
  static BackgroundFetchService get instance => _instance;

  StreamSubscription<LocationData>? _locationSubscription;
  @override
  Future<void> startBackground(
      {required TrackingStatusEnum trackingStatus,
      required Set<Marker> markers,
      required List<LatLng> polylineCoordinatesList,
      required LocationData? lastMarkerPosition}) async {
    if (trackingStatus == TrackingStatusEnum.STOPED || trackingStatus == TrackingStatusEnum.STARTED_PAUSED) return;
    final locationCacheOperationBackground = LocationStoreFunction(locationStore: ProductStateItems.productCache.locationCacheOperation);
    final backgroundMarkers = markers;
    final backgroundPolylineCoordinatesList = polylineCoordinatesList;
    await BackgroundFetch.start();
    trackingStatus = TrackingStatusEnum.BACKGROUND;
    Location location = Location();
    if (_locationSubscription != null) {
      _locationSubscription?.cancel();
      _locationSubscription = null;
    }
    _locationSubscription = location.onLocationChanged.listen((LocationData location) {
      final latitude = location.latitude;
      final longitude = location.longitude;
      if (lastMarkerPosition?.longitude != null && lastMarkerPosition?.latitude != null && latitude != null && longitude != null) {
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
      } else if (latitude != null && longitude != null) {
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
      print("successfully running ${DateTime.now()}");
    });
  }

  @override
  Future<void> stopTrackingBackground(Future<void> Function() onStop) async {
    // final service = fb.FlutterBackgroundService();
    _locationSubscription?.cancel();
    _locationSubscription = null;
    debugPrint("stop service");
    await BackgroundFetch.stop();
  }

  @override
  Future<void> initializeService() async {
    int status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.NONE), (String taskId) async {
      // <-- Event handler
      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      // <-- Task timeout handler.
      // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
      print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
      BackgroundFetch.finish(taskId);
    });
    print('[BackgroundFetch] configure success: $status');
  }
}
