import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marti_location_tracking/product/assets/asset.dart';
import 'package:marti_location_tracking/product/components/base_widgets/marti_scaffold.dart';
import 'package:marti_location_tracking/product/components/dialog/info_dialog.dart';
import 'package:marti_location_tracking/product/navigation/app_router_handler.gr.dart';
import 'package:marti_location_tracking/product/utils/extensions/context_extension.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:marti_location_tracking/product/utils/permission_function.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  int loopCount = 0;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    checkPermission();
  }

  Future<void> checkPermission() async {
    final response = await PermissionFunction.instance.checkLocationPermission(context);
    if (response) {
      navigateToHome();
    } else {
      if (mounted) {
        InfoDialog.show(
          context: context,
          title: 'İzni reddedersen, bu hizmeti kullanamazsın. Ayarlar > İzinler e giderek izinleri açınız',
          onTapOk: () => exit(0),
        );
      }
    }
  }

  Future<void> navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 2700));
    if (mounted) {
      context.router.replace(DashBoardRoute());
    }
  }

  Future<void> setConfig() async {
    bg.Config params = bg.Config(
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter: 10.0,
      stopOnTerminate: false,
      startOnBoot: true,
      debug: true,
      backgroundPermissionRationale: bg.PermissionRationale(
        title: 'Allow location tracking',
        message: 'This app tracks your location to provide you with the best experience.',
        positiveAction: 'Allow',
        negativeAction: 'Deny',
      ),
    );
    bg.BackgroundGeolocation.ready(params).then((bg.State state) {
      print('[ready] BackgroundGeolocation is configured and ready to use');
    });
// To modify config after #ready has been executed, use #setConfig
    bg.BackgroundGeolocation.setConfig(bg.Config()).then((bg.State state) {
      bg.BackgroundGeolocation.sync();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MartiScaffold(
      extendBodyBehindAppBar: true,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: context.colorScheme.primary),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Assets.lottie.martiLogo.lottie(
              width: 100,
            ),
          ),
        ),
      ),
    );
  }
}
