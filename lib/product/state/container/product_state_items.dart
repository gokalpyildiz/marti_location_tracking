import 'package:marti_location_tracking/product/cache/product_cache.dart';
import 'package:marti_location_tracking/product/navigation/app_router_handler.dart';
import 'package:marti_location_tracking/product/state/container/product_state_container.dart';
import 'package:marti_location_tracking/product/state/viewmodel/project_cubit.dart';

final class ProductStateItems {
  const ProductStateItems._();

  static ProjectCubit get projectCubit => ProductContainer.readDepInj<ProjectCubit>();
  static ProductCache get productCache => ProductContainer.readDepInj<ProductCache>();
  static AppRouter get appRouterHandler => ProductContainer.readDepInj<AppRouter>();
}
