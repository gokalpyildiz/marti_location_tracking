import 'package:flutter/material.dart';

/// Project custom colors
final class CustomColorScheme {
  CustomColorScheme._();

  /// Light color scheme set
  //xx =>dont change because is used
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(3, 209, 1, 1), //xx
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color.fromRGBO(243, 244, 246, 1),
    onPrimaryContainer: Color.fromRGBO(107, 114, 128, 1),
    secondary: Color.fromRGBO(15, 21, 35, 1), //XX
    onSecondary: Color.fromRGBO(107, 114, 128, 1), //XX
    secondaryContainer: Color.fromRGBO(195, 221, 253, 1),
    onSecondaryContainer: Color(0xFF1D192B),
    tertiary: Color(0xFF7D5260),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFD8E4),
    onTertiaryContainer: Color(0xFF31111D),
    error: Color.fromRGBO(255, 82, 71, 1),
    //error: ColorName.crimsonRed,
    onError: Color(0xFFFFFFFF),
    errorContainer: Color.fromRGBO(255, 229, 228, 1),
    onErrorContainer: Color(0xFF410E0B),
    outline: Color.fromRGBO(209, 213, 219, 1),
    surface: Color(0xFFFFFFFF),
    onSurface: Color.fromRGBO(15, 21, 35, 1),
    surfaceContainer: Color.fromRGBO(229, 231, 235, 1),
    surfaceContainerHighest: Color(0xFFE7E0EC),
    onSurfaceVariant: Color.fromRGBO(88, 93, 104, 1),
    inverseSurface: Color(0xFF313033),
    onInverseSurface: Color(0xFFF4EFF4),
    inversePrimary: Color(0xFFD0BCFF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF6750A4),
    outlineVariant: Color(0xFFCAC4D0),
    scrim: Color(0xFF000000),
  );

  /// Light dark scheme set
  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFD0BCFF),
    onPrimary: Color(0xFF381E72),
    primaryContainer: Color(0xFF4F378B),
    onPrimaryContainer: Color(0xFFEADDFF),
    secondary: Color(0xFFCCC2DC),
    onSecondary: Color(0xFF332D41),
    secondaryContainer: Color(0xFF4A4458),
    onSecondaryContainer: Color(0xFFE8DEF8),
    tertiary: Color(0xFFEFB8C8),
    onTertiary: Color(0xFF492532),
    tertiaryContainer: Color(0xFF633B48),
    onTertiaryContainer: Color(0xFFFFD8E4),
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Color(0xFFF9DEDC),
    outline: Color(0xFF938F99),
    surface: Color(0xFF1C1B1F),
    onSurface: Color(0xFFE6E1E5),
    surfaceContainerHighest: Color(0xFF49454F),
    onSurfaceVariant: Color(0xFFCAC4D0),
    inverseSurface: Color(0xFFE6E1E5),
    onInverseSurface: Color(0xFF313033),
    inversePrimary: Color(0xFF6750A4),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFD0BCFF),
    outlineVariant: Color(0xFF49454F),
    scrim: Color(0xFF000000),
  );
}

//todo dark ve light için ayrı ayrı renkler oluşturulmalı bunun için abstract bir class vs oluşturulabilir.
extension CustomColorSchemeExtension on ColorScheme {
  Color get success => Color.fromRGBO(35, 193, 107, 1);
  // Color get info => const Color(0xFF17a2b8);
  // Color get warning => const Color(0xFFffc107);
  // Color get danger => const Color(0xFFdc3545);
}
