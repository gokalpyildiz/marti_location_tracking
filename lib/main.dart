import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marti_location_tracking/product/initialize/application_start.dart';
import 'package:marti_location_tracking/product/initialize/state_initialize.dart';
import 'package:marti_location_tracking/product/state/container/product_state_items.dart';
import 'package:marti_location_tracking/product/state/viewmodel/project_cubit.dart';
import 'package:marti_location_tracking/product/theme/custom_dark_theme.dart';
import 'package:marti_location_tracking/product/theme/custom_light_theme.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(const StateInitialize(child: MyApp()));
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: ProductStateItems.appRouterHandler.config(),
      theme: CustomLightTheme().themeData,
      darkTheme: CustomDarkTheme().themeData,
      themeMode: context.watch<ProjectCubit>().state.themeMode,
      debugShowCheckedModeBanner: false,
    );
  }
}
