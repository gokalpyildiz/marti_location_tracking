import 'package:marti_location_tracking/product/cache/base/cache_manager.dart';

final class ProductCache {
  ProductCache({required CacheManager cacheManager}) : _cacheManager = cacheManager;

  final CacheManager _cacheManager;

  Future<void> init() async => await _cacheManager.init();
}
