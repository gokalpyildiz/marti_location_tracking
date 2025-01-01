import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:marti_location_tracking/product/enum/tracking_status_enum.dart';
import 'package:marti_location_tracking/product/state/container/product_state_items.dart';
import 'package:marti_location_tracking/product/utils/background_services/base/ILocationBackgroundService.dart';
import 'package:marti_location_tracking/product/utils/cache_functions/location_store_function.dart';
import 'package:geolocator/geolocator.dart' as geolocator;

class PlatformChannelService implements IBackgroundService {
  PlatformChannelService._init();
  static final PlatformChannelService _instance = PlatformChannelService._init();
  static PlatformChannelService get instance => _instance;
  static const platformChannel = MethodChannel('com.gokalpyildiz.marti_location_tracking');
  @override
  Future<void> startBackground(
      {required TrackingStatusEnum trackingStatus,
      required Set<Marker> markers,
      required List<LatLng> polylineCoordinatesList,
      required LocationData? lastMarkerPosition}) async {
    try {
      if (trackingStatus == TrackingStatusEnum.STOPED || trackingStatus == TrackingStatusEnum.STARTED_PAUSED) return;
      final locationCacheOperationBackground = LocationStoreFunction(locationStore: ProductStateItems.productCache.locationCacheOperation);
      final backgroundMarkers = markers;
      final backgroundPolylineCoordinatesList = polylineCoordinatesList;
      trackingStatus = TrackingStatusEnum.BACKGROUND;
      final String result = await platformChannel.invokeMethod('startBackground');
      final locationUpdates = _LocationUpdates();
      locationUpdates.locationStream.listen((locationData) {
        final location = LatLng(locationData['latitude']!, locationData['longitude']!);
        final latitude = location.latitude;
        final longitude = location.longitude;
        debugPrint('Location: ${location.latitude} - ${location.longitude}');
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
      });
      debugPrint(result);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> stopTrackingBackground(Future<void> Function() onStop) async {
    await platformChannel.invokeMethod('stopBackground');
  }

  @override
  Future<void> initializeService() async {}
}

class _LocationUpdates {
  static const EventChannel _eventChannel = EventChannel('com.gokalpyildiz.marti_location_updates');

  Stream<Map<String, double>> get locationStream {
    var response = _eventChannel.receiveBroadcastStream().map((event) => Map<String, double>.from(event));
    return response;
  }
}
