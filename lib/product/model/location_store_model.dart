import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:marti_location_tracking/product/cache/hive/hive_type_ids.dart';
import 'package:marti_location_tracking/product/model/latlng_store_model.dart';
import 'package:marti_location_tracking/product/model/marker_store_model.dart';

part 'location_store_model.g.dart';

@HiveType(typeId: HiveTypeIds.locationStoreModel)
class LocationStoreModel extends Equatable {
  const LocationStoreModel({
    this.isFinished,
    this.markers,
    this.polylines,
  });

  @HiveField(0)
  final bool? isFinished;
  @HiveField(1)
  final List<MarkerStoreModel>? markers;
  @HiveField(2)
  final List<LatlngStoreModel>? polylines;

  @override
  List<Object?> get props => [
        isFinished,
        markers,
        polylines,
      ];
}
