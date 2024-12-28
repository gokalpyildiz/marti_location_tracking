import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_location_tracking/product/components/base_widgets/marti_scaffold.dart';
import 'package:marti_location_tracking/views/location_tracking/viewmodel/location_tracking_cubit.dart';
part 'subwidgets/location_tracking_map.dart';
part 'mixin/location_tracking_map_mixin.dart';

@RoutePage()
class LocationTrackingView extends StatefulWidget {
  const LocationTrackingView({super.key});

  @override
  State<LocationTrackingView> createState() => _LocationTrackingViewState();
}

class _LocationTrackingViewState extends State<LocationTrackingView> with WidgetsBindingObserver {
  late final LocationTrackingCubit cubit;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    cubit = LocationTrackingCubit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        print("Uygulama ön planda.");
        break;
      case AppLifecycleState.inactive:
        print("Uygulama inaktif.");
        break;
      case AppLifecycleState.paused:
        print("Uygulama arka planda.");
        break;
      case AppLifecycleState.detached:
        print("Uygulama kapatılıyor.");
        break;
      case AppLifecycleState.hidden:
        print("Uygulama gizlendi.");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: SafeArea(
        child: BlocBuilder<LocationTrackingCubit, LocationTrackingState>(
          builder: (context, state) {
            return MartiScaffold(
              child: state.isLoading
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Center(child: _LocationTrackingMap()),
            );
          },
        ),
      ),
    );
  }
}
