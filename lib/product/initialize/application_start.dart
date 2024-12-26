import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marti_location_tracking/product/state/container/product_state_container.dart';
import 'package:marti_location_tracking/product/state/container/product_state_items.dart';

@immutable
final class ApplicationStart {
  const ApplicationStart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await runZonedGuarded<Future<void>>(
      () async {
        await _initialize();
      },
      (error, stack) {
        debugPrint('runZonedGuarded: Caught error: $error');
      },
    );
  }

  static Future<void> _initialize() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _productEnvironmentWithContainer();
    await ProductStateItems.productCache.init();
  }

  static void _productEnvironmentWithContainer() {
    //AppDependencyInjection.instance.setupGetItLocators();

    /// It must be call after [AppEnvironment.general()]
    ProductContainer.setup();
  }
}
