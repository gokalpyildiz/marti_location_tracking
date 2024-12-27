abstract class CacheManager {
  CacheManager({this.path});

  /// Make your cache initialization here.
  Future<void> init();

  /// Remove all cache.
  void remove();

  /// [path] is the path to the directory for example testing
  final String? path;
}
