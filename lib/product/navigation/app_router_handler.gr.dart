// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:marti_location_tracking/product/navigation/app_router.dart'
    as _i4;
import 'package:marti_location_tracking/views/activity_detail/view/activity_detail_view.dart'
    as _i1;
import 'package:marti_location_tracking/views/dashboard/view/dashboard_view.dart'
    as _i2;
import 'package:marti_location_tracking/views/location_tracking/view/location_tracking_view.dart'
    as _i3;
import 'package:marti_location_tracking/views/profile/view/profile_view.dart'
    as _i5;
import 'package:marti_location_tracking/views/splash/view/splash_view.dart'
    as _i6;

/// generated route for
/// [_i1.ActivityDetailView]
class ActivityDetailRoute extends _i7.PageRouteInfo<ActivityDetailRouteArgs> {
  ActivityDetailRoute({
    _i8.Key? key,
    required int activityIndex,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          ActivityDetailRoute.name,
          args: ActivityDetailRouteArgs(
            key: key,
            activityIndex: activityIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'ActivityDetailRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ActivityDetailRouteArgs>();
      return _i1.ActivityDetailView(
        key: args.key,
        activityIndex: args.activityIndex,
      );
    },
  );
}

class ActivityDetailRouteArgs {
  const ActivityDetailRouteArgs({
    this.key,
    required this.activityIndex,
  });

  final _i8.Key? key;

  final int activityIndex;

  @override
  String toString() {
    return 'ActivityDetailRouteArgs{key: $key, activityIndex: $activityIndex}';
  }
}

/// generated route for
/// [_i2.DashBoardView]
class DashBoardRoute extends _i7.PageRouteInfo<void> {
  const DashBoardRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DashBoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashBoardRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashBoardView();
    },
  );
}

/// generated route for
/// [_i3.LocationTrackingView]
class LocationTrackingRoute extends _i7.PageRouteInfo<void> {
  const LocationTrackingRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LocationTrackingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LocationTrackingRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.LocationTrackingView();
    },
  );
}

/// generated route for
/// [_i4.ProfileTabView]
class ProfileTabRoute extends _i7.PageRouteInfo<void> {
  const ProfileTabRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ProfileTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileTabRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.ProfileTabView();
    },
  );
}

/// generated route for
/// [_i5.ProfileView]
class ProfileRoute extends _i7.PageRouteInfo<void> {
  const ProfileRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.ProfileView();
    },
  );
}

/// generated route for
/// [_i6.SplashView]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashView();
    },
  );
}
