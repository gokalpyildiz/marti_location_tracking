import 'package:auto_route/auto_route.dart';
import 'package:marti_location_tracking/product/navigation/app_router_handler.gr.dart';

class AppRoute {
  static const splash = '/splash';
  static const locationTracking = '/locationTracking';
  static const locationTrackingNested = 'locationTracking';
  static const dashboard = '/dashboard';
  static const profile = '/profile';
  static const profileNested = 'profile';

  static List<AutoRoute> routes = [
    splashRoute,
    dashboardRoute,
  ];
  static AutoRoute splashRoute = CustomRoute(
    path: splash,
    initial: true,
    page: SplashRoute.page,
    transitionsBuilder: TransitionsBuilders.slideLeft,
  );

  static AutoRoute dashboardRoute = AutoRoute(path: dashboard, page: DashBoardRoute.page, children: [
    AutoRoute(path: locationTrackingNested, page: LocationTrackingRoute.page, initial: true),
    AutoRoute(path: profileNested, page: ProfileRoute.page, maintainState: false),
  ]);
}
