import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geoLocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:marti_location_tracking/product/components/base_widgets/marti_scaffold.dart';
part 'subwidgets/location_tracking_map.dart';
part 'mixin/location_tracking_map_mixin.dart';

@RoutePage()
class LocationTrackingView extends StatefulWidget {
  const LocationTrackingView({super.key});

  @override
  State<LocationTrackingView> createState() => _LocationTrackingViewState();
}

class _LocationTrackingViewState extends State<LocationTrackingView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MartiScaffold(
        child: Center(child: _LocationTrackingMap()),
      ),
    );
  }
}
