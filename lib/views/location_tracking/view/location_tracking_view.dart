import 'package:flutter/material.dart';
import 'package:marti_location_tracking/product/assets/asset.dart';
import 'package:marti_location_tracking/product/components/base_widgets/marti_scaffold.dart';

class LocationTrackingView extends StatelessWidget {
  const LocationTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return MartiScaffold(
      child: Center(
        child: Assets.lottie.martiLogo.lottie(
          width: 90,
          height: 90,
        ),
      ),
    );
  }
}
