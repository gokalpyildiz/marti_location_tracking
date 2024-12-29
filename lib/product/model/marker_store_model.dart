import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:marti_location_tracking/product/cache/hive/hive_type_ids.dart';

part 'marker_store_model.g.dart';

@HiveType(typeId: HiveTypeIds.markerStoreModel)
class MarkerStoreModel extends Equatable {
  const MarkerStoreModel({
    this.markerId,
    this.markerLat,
    this.markerLong,
  });

  @HiveField(0)
  final String? markerId;
  @HiveField(1)
  final double? markerLat;
  @HiveField(2)
  final double? markerLong;

  @override
  List<Object?> get props => [
        markerId,
        markerLat,
        markerLong,
      ];
}
