// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:marti_location_tracking/views/dashboard/view/dashboard_view.dart'
    as _i1;
import 'package:marti_location_tracking/views/location_tracking/view/location_tracking_view.dart'
    as _i2;
import 'package:marti_location_tracking/views/profile/view/profile_view.dart'
    as _i3;
import 'package:marti_location_tracking/views/splash/view/splash_view.dart'
    as _i4;

/// generated route for
/// [_i1.DashBoardView]
class DashBoardRoute extends _i5.PageRouteInfo<void> {
  const DashBoardRoute({List<_i5.PageRouteInfo>? children})
      : super(
          DashBoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashBoardRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.DashBoardView();
    },
  );
}

/// generated route for
/// [_i2.LocationTrackingView]
class LocationTrackingRoute extends _i5.PageRouteInfo<void> {
  const LocationTrackingRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LocationTrackingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LocationTrackingRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.LocationTrackingView();
    },
  );
}

/// generated route for
/// [_i3.ProfileView]
class ProfileRoute extends _i5.PageRouteInfo<void> {
  const ProfileRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.ProfileView();
    },
  );
}

/// generated route for
/// [_i4.SplashView]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashView();
    },
  );
}
