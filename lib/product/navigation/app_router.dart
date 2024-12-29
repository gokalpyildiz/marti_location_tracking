import 'package:auto_route/auto_route.dart';
import 'package:marti_location_tracking/product/navigation/app_router_handler.gr.dart';

class AppRoute {
  static const splash = '/splash';
  static const locationTracking = '/locationTracking';
  static const locationTrackingNested = 'locationTracking';
  static const dashboard = '/dashboard';
  static const profile = '/profile';
  static const profileNested = 'profile';
  static const profileTab = 'profileTab';
  static const activityDetail = '/activityDetail';
  static const activityDetailNested = 'activityDetail';

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
    AutoRoute(page: ProfileTabRoute.page, path: profileTab, maintainState: true, children: [
      AutoRoute(path: profileNested, page: ProfileRoute.page, maintainState: false),
      AutoRoute(path: activityDetailNested, page: ActivityDetailRoute.page),
    ]),
  ]);
}

@RoutePage()
class ProfileTabView extends AutoRouter {
  const ProfileTabView({super.key});
}
