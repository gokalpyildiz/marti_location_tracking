import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:marti_location_tracking/product/cache/hive/hive_type_ids.dart';

part 'latlng_store_model.g.dart';

@HiveType(typeId: HiveTypeIds.latlngStoreModel)
class LatlngStoreModel extends Equatable {
  const LatlngStoreModel({
    this.latitude,
    this.longitude,
  });

  @HiveField(0)
  final double? latitude;
  @HiveField(1)
  final double? longitude;

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
