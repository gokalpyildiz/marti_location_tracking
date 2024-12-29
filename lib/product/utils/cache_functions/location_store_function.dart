import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_location_tracking/product/cache/hive/database_keys.dart';
import 'package:marti_location_tracking/product/model/latlng_store_model.dart';
import 'package:marti_location_tracking/product/model/location_store_model.dart';
import 'package:marti_location_tracking/product/model/location_store_response_model.dart';
import 'package:marti_location_tracking/product/model/marker_store_model.dart';
import 'package:marti_location_tracking/product/state/container/product_state_items.dart';

class LocationStoreFunction {
  LocationStoreFunction._init();
  static final LocationStoreFunction _instance = LocationStoreFunction._init();
  static LocationStoreFunction get instance => _instance;
  final _locationStore = ProductStateItems.productCache.locationCacheOperation;

  Future<void> updateUnfinishedLocation({required bool isFinished, required Set<Marker> markers, required List<LatLng> polylines}) async {
    List<MarkerStoreModel> markerStoreList = [];
    List<LatlngStoreModel> polyLineList = [];
    for (var element in polylines) {
      polyLineList.add(LatlngStoreModel(
        latitude: element.latitude,
        longitude: element.longitude,
      ));
    }
    for (var element in markers) {
      markerStoreList.add(MarkerStoreModel(
        markerId: element.markerId.toString(),
        markerLat: element.position.latitude,
        markerLong: element.position.longitude,
      ));
    }
    LocationStoreModel locationStoreModel = LocationStoreModel(
      isFinished: isFinished,
      markers: markerStoreList,
      polylines: polyLineList,
    );
    await _locationStore.add(item: locationStoreModel, key: DatabaseKeys.LAST_UNFINISHED_TRACKING.value);
  }

  Future<LocationStoreResponseModel?> getUnfinishedRoute(Function(double latitude, double longitude) openMarkerAddress) async {
    final lastUnfinishedRoute = await _locationStore.get(DatabaseKeys.LAST_UNFINISHED_TRACKING.value);
    if (lastUnfinishedRoute?.isFinished == false) {
      List<Marker> markers = [];
      List<LatLng> polylines = [];
      for (var element in lastUnfinishedRoute!.markers!) {
        markers.add(Marker(
            markerId: MarkerId(element.markerId!),
            position: LatLng(element.markerLat!, element.markerLong!),
            onTap: () {
              openMarkerAddress(element.markerLat!, element.markerLong!);
            }));
      }
      for (var element in lastUnfinishedRoute.polylines!) {
        polylines.add(LatLng(element.latitude!, element.longitude!));
      }
      return LocationStoreResponseModel(
        isFinished: lastUnfinishedRoute.isFinished,
        markers: markers.toSet(),
        polylines: polylines,
      );
    }
    return null;
  }

  Future<void> deleteUnfinishedRoute() async {
    await _locationStore.remove(DatabaseKeys.LAST_UNFINISHED_TRACKING.value);
  }

  Future<void> clear() async {
    await _locationStore.clear();
  }
}
