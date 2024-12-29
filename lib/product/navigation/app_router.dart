import 'package:auto_route/auto_route.dart';
import 'package:marti_location_tracking/product/navigation/app_router_handler.gr.dart';

class AppRoute {
  static const splash = '/splash';
  static const locationTracking = '/locationTracking';

  static AutoRoute photoFullScreenRoute = AutoRoute(
    path: locationTracking,
    page: LocationTrackingRoute.page,
  );
  static AutoRoute splashRoute = CustomRoute(
    path: splash,
    initial: true,
    page: SplashRoute.page,
    transitionsBuilder: TransitionsBuilders.slideLeft,
  );

  static List<AutoRoute> routes = [
    splashRoute,
    photoFullScreenRoute,
  ];
}
