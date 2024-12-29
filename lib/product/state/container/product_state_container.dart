import 'package:get_it/get_it.dart';
import 'package:marti_location_tracking/product/cache/hive/hive_cache_manager.dart';
import 'package:marti_location_tracking/product/cache/product_cache.dart';
import 'package:marti_location_tracking/product/navigation/app_router_handler.dart';
import 'package:marti_location_tracking/product/state/viewmodel/project_cubit.dart';
import 'package:marti_location_tracking/views/dashboard/viewmodel/dashboard_cubit.dart';

/// Product container for dependency injection
final class ProductContainer {
  const ProductContainer._();
  static final _getIt = GetIt.I;

  /// Product core required items
  static void setup() {
    //buraya eklenenler ProductStateItems a eklenerek kullanılabilir.
    _getIt
      //lazysingleton çağrıldığında oluşturulur verimlilik için, singleton doğrudan kullanılır.
      ..registerSingleton<ProductCache>(ProductCache(cacheManager: HiveCacheManager()))
      ..registerLazySingleton<ProjectCubit>(ProjectCubit.new)
      ..registerLazySingleton<DashboardCubit>(DashboardCubit.new)
      ..registerLazySingleton<AppRouter>(AppRouter.new);
  }

  /// read your dependency item for [ProductContainer]
  static T readDepInj<T extends Object>() => _getIt<T>();
}
