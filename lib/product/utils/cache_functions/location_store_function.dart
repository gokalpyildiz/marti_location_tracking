import 'dart:async';
import 'dart:typed_data';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_location_tracking/product/cache/hive/database_keys.dart';
import 'package:marti_location_tracking/product/cache/hive/hive_cache_operation.dart';
import 'package:marti_location_tracking/product/model/latlng_store_model.dart';
import 'package:marti_location_tracking/product/model/location_store_model.dart';
import 'package:marti_location_tracking/product/model/location_store_response_model.dart';
import 'package:marti_location_tracking/product/model/marker_store_model.dart';

class LocationStoreFunction {
  static LocationStoreFunction? _instance;
  factory LocationStoreFunction({
    required HiveCacheOperation<LocationStoreModel> locationStore,
  }) {
    _instance ??= LocationStoreFunction._internal(
      locationStore: locationStore,
    );
    return _instance!;
  }
  late final HiveCacheOperation<LocationStoreModel> _locationStore;
  LocationStoreFunction._internal({
    required HiveCacheOperation<LocationStoreModel> locationStore,
  }) {
    _locationStore = locationStore;
  }

  //save completed activities
  Future<void> addFinishedLocation({required Set<Marker> markers, required List<LatLng> polylines, required Uint8List? image}) async {
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
      isFinished: true,
      markers: markerStoreList,
      polylines: polyLineList,
      image: image,
      date: DateTime.now(),
    );
    await _locationStore.insert(item: locationStoreModel);
  }

  //updates ongoing activity
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

  //getting activity in progress
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
        date: lastUnfinishedRoute.date,
      );
    }
    return null;
  }

  //getting completed activities
  Future<List<LocationStoreResponseModel?>> getAll(Function(double latitude, double longitude) openMarkerAddress) async {
    final allActivities = await _locationStore.getList();
    List<LocationStoreResponseModel?> response = [];
    for (var element in allActivities ?? <LocationStoreModel>[]) {
      if (element.isFinished == true) {
        List<Marker> markers = [];
        List<LatLng> polylines = [];
        for (var element in element.markers!) {
          markers.add(Marker(
              markerId: MarkerId(element.markerId!),
              position: LatLng(element.markerLat!, element.markerLong!),
              onTap: () {
                openMarkerAddress(element.markerLat!, element.markerLong!);
              }));
        }
        for (var element in element.polylines!) {
          polylines.add(LatLng(element.latitude!, element.longitude!));
        }
        var item = LocationStoreResponseModel(
          isFinished: element.isFinished,
          markers: markers.toSet(),
          polylines: polylines,
          image: element.image,
          date: element.date,
        );
        response.add(item);
      }
    }
    return response;
  }

  Future<void> deleteUnfinishedRoute() async {
    await _locationStore.remove(DatabaseKeys.LAST_UNFINISHED_TRACKING.value);
  }

  Future<void> clear() async {
    await _locationStore.clear();
  }

  Future<void> removeItem(int key) async {
    await _locationStore.removeAt(key);
  }
}
