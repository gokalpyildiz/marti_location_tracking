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
  });

  @HiveField(0)
  final bool? isFinished;
  @HiveField(1)
  final Set<Marker>? markers;
  @HiveField(2)
  final List<LatLng>? polylines;

  @override
  List<Object?> get props => [
        isFinished,
        markers,
        polylines,
      ];
}
