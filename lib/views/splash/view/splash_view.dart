import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marti_location_tracking/product/assets/asset.dart';
import 'package:marti_location_tracking/product/components/base_widgets/marti_scaffold.dart';
import 'package:marti_location_tracking/product/navigation/app_router_handler.gr.dart';
import 'package:marti_location_tracking/product/utils/extensions/context_extension.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    navigateToHome();
  }

  Future<void> navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 2700));
    if (mounted) {
      context.router.replace(DashBoardRoute());
    }
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
