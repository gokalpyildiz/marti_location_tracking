import 'package:marti_location_tracking/product/cache/hive/hive_cache_operation.dart';
import 'package:marti_location_tracking/product/model/location_store_model.dart';
import 'package:mockito/mockito.dart';

class LocationsCacheMock extends Mock implements HiveCacheOperation<LocationStoreModel> {
  final List<LocationStoreModel> _bannerList = [];
  @override
  Future<void> add({required String key, required LocationStoreModel item}) async {
    _bannerList.add(item);
  }

  @override
  Future<LocationStoreModel?> get(String key) async {
    return _bannerList.firstOrNull;
  }
}
