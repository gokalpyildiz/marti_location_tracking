import 'package:flutter/material.dart';
import 'package:marti_location_tracking/product/constants/ui_constants.dart';
import 'package:marti_location_tracking/product/theme/custom_color_scheme.dart';
import 'package:marti_location_tracking/product/theme/custom_theme.dart';

/// Custom light theme for project design
final class CustomLightTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
        //xx =>dont change because is used
        useMaterial3: true,
        fontFamily: UIConstants.appFontFamily().fontFamily,
        colorScheme: CustomColorScheme.lightColorScheme,
        floatingActionButtonTheme: floatingActionButtonThemeData,
        appBarTheme: appBarTheme,
        dividerColor: const Color.fromRGBO(209, 213, 219, 1),
        hintColor: const Color.fromRGBO(136, 140, 147, 1),
      );

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData => const FloatingActionButtonThemeData();
  AppBarTheme get appBarTheme => AppBarTheme(backgroundColor: CustomColorScheme.lightColorScheme.onPrimary, scrolledUnderElevation: 0);
}
