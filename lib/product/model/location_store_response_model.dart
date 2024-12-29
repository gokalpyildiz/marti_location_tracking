// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:marti_location_tracking/product/cache/hive/hive_type_ids.dart';

@HiveType(typeId: HiveTypeIds.locationStoreModel)
class LocationStoreResponseModel extends Equatable {
  const LocationStoreResponseModel({
    this.isFinished,
    this.markers,
    this.polylines,
    this.image,
  });

  @HiveField(0)
  final bool? isFinished;
  @HiveField(1)
  final Set<Marker>? markers;
  @HiveField(2)
  final List<LatLng>? polylines;
  @HiveField(3)
  final Uint8List? image;

  @override
  List<Object?> get props => [
        isFinished,
        markers,
        image,
        polylines,
      ];

  LocationStoreResponseModel copyWith({
    bool? isFinished,
    Set<Marker>? markers,
    List<LatLng>? polylines,
    Uint8List? image,
  }) {
    return LocationStoreResponseModel(
      isFinished: isFinished ?? this.isFinished,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      image: image ?? this.image,
    );
  }
}
