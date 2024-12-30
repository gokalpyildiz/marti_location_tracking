import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:marti_location_tracking/product/enum/tracking_status_enum.dart';

abstract class IBackgroundService {
  Future<void> startBackground(
      {required TrackingStatusEnum trackingStatus,
      required Set<Marker> markers,
      required List<LatLng> polylineCoordinatesList,
      required LocationData? lastMarkerPosition});
  void stopTrackingBackground(Future<void> Function() onStop);
  Future<void> initializeService();
}
