import 'package:auto_route/auto_route.dart';
import 'package:marti_location_tracking/product/navigation/app_router_handler.gr.dart';

class AppRoute {
  static const locationTracking = '/locationTracking';

  static AutoRoute photoFullScreenRoute = AutoRoute(
    path: locationTracking,
    initial: true,
    page: LocationTrackingRoute.page,
  );

  static List<AutoRoute> routes = [
    photoFullScreenRoute,
  ];
}
