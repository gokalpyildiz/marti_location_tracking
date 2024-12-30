import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:marti_location_tracking/product/enum/tracking_status_enum.dart';
import 'package:marti_location_tracking/product/state/container/product_state_items.dart';
import 'package:marti_location_tracking/product/utils/background_services/base/ILocationBackgroundService.dart';
import 'package:marti_location_tracking/product/utils/cache_functions/location_store_function.dart';
import 'package:flutter_background_service/flutter_background_service.dart' as fb;
import 'package:geolocator/geolocator.dart' as geolocator;

class FlutterBackgroundService implements IBackgroundService {
  FlutterBackgroundService._init();
  static final FlutterBackgroundService _instance = FlutterBackgroundService._init();
  static FlutterBackgroundService get instance => _instance;
  final _service = fb.FlutterBackgroundService();
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
    _service.startService();
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
    _service.invoke("stop");
  }

  @override
  Future<void> initializeService() async {
    await _service.configure(
      iosConfiguration: fb.IosConfiguration(
        autoStart: false,
        onForeground: _onStart,
        onBackground: _onIosBackground,
      ),
      androidConfiguration: fb.AndroidConfiguration(
        autoStart: false,
        onStart: _onStart,
        isForegroundMode: false,
        autoStartOnBoot: true,
      ),
    );
  }

  @pragma('vm:entry-point')
  Future<bool> _onIosBackground(fb.ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    return true;
  }

  @pragma('vm:entry-point')
  static void _onStart(fb.ServiceInstance service) async {
    service.on("stop").listen((event) {
      service.stopSelf();
      debugPrint("background process is now stopped ${DateTime.now().toString()}");
    });

    service.on("start").listen((event) {});
  }
}
