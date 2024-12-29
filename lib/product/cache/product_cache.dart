import 'package:marti_location_tracking/product/cache/base/cache_manager.dart';
import 'package:marti_location_tracking/product/cache/hive/hive_box_names.dart';
import 'package:marti_location_tracking/product/cache/hive/hive_cache_operation.dart';
import 'package:marti_location_tracking/product/model/location_store_model.dart';

final class ProductCache {
  ProductCache({required CacheManager cacheManager}) : _cacheManager = cacheManager;

  final CacheManager _cacheManager;

  Future<void> init() async => await _cacheManager.init();
  late final HiveCacheOperation<LocationStoreModel> locationCacheOperation = HiveCacheOperation<LocationStoreModel>(HiveBoxNames.location.value);
}
