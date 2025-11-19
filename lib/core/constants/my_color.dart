import 'package:flutter/material.dart';

class MyColor {
  // Basic colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Gray scale (from new design system)
  static const Color gray25 = Color(0xFFFCFCFD);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF2F4F7);
  static const Color gray200 = Color(0xFFEAECF0);
  static const Color gray300 = Color(0xFFD0D5DD);
  static const Color gray400 = Color(0xFF98A2B3);
  static const Color gray500 = Color(0xFF667085);
  static const Color gray600 = Color(0xFF475467);
  static const Color gray700 = Color(0xFF344054);
  static const Color gray800 = Color(0xFF1D2939);
  static const Color gray900 = Color(0xFF101828);

  // Semantic colors (updated with new values)
  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFFFFE6E6);
  static const Color onErrorContainer = Color(0xFF000000);
  static const Color warning = Color(0xFFDC6803);
  static const Color success = Color(0xFF079455);

  // Primary colors (from new color scheme)
  static const Color primary = Color(0xFF7C3AED);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF7C3AED);
  static const Color onPrimaryContainer = Color(0xFFFFFFFF);
  static const Color primaryFixed = Color(0xFFE3D9F6);
  static const Color primaryFixedDim = Color(0xFFC5AFEB);
  static const Color onPrimaryFixed = Color(0xFF360C7F);
  static const Color onPrimaryFixedVariant = Color(0xFF3D0D90);

  // Secondary colors
  static const Color secondary = Color(0xFFF3F4F6);
  static const Color onSecondary = Color(0xFF000000);
  static const Color secondaryContainer = Color(0xFFF3F4F6);
  static const Color onSecondaryContainer = Color(0xFF000000);
  static const Color secondaryFixed = Color(0xFFFAFAFA);
  static const Color secondaryFixedDim = Color(0xFFF0F0F1);
  static const Color onSecondaryFixed = Color(0xFF3E4654);
  static const Color onSecondaryFixedVariant = Color(0xFF5A6479);

  // Surface colors
  static const Color surface = Color(0xFFFCFCFC);
  static const Color onSurface = Color(0xFF111111);
  static const Color surfaceDim = Color(0xFFE0E0E0);
  static const Color surfaceBright = Color(0xFFFDFDFD);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF8F8F8);
  static const Color surfaceContainer = Color(0xFFF3F3F3);
  static const Color surfaceContainerHigh = Color(0xFFEDEDED);
  static const Color surfaceContainerHighest = Color(0xFFE7E7E7);
  static const Color onSurfaceVariant = Color(0xFF393939);

  // Outline colors
  static const Color outline = Color(0xFF919191);
  static const Color outlineVariant = Color(0xFFD1D1D1);

  // Dark theme specific colors
  static const Color darkError = Color(0xFF7F1D1D);
  static const Color darkErrorContainer = Color(0xFF410F0F);
  static const Color darkOnErrorContainer = Color(0xFFFFFFFF);
  static const Color darkSurface = Color(0xFF080808);
  static const Color darkOnSurface = Color(0xFFF1F1F1);
  static const Color darkSurfaceDim = Color(0xFF060606);
  static const Color darkSurfaceBright = Color(0xFF2C2C2C);
  static const Color darkSurfaceContainerLowest = Color(0xFF010101);
  static const Color darkSurfaceContainerLow = Color(0xFF0E0E0E);
  static const Color darkSurfaceContainer = Color(0xFF151515);
  static const Color darkSurfaceContainerHigh = Color(0xFF1D1D1D);
  static const Color darkSurfaceContainerHighest = Color(0xFF282828);
  static const Color darkOnSurfaceVariant = Color(0xFFCACACA);
  static const Color darkOutline = Color(0xFF777777);
  static const Color darkOutlineVariant = Color(0xFF414141);

  // MaterialColor for primary (updated with purple shades)
  static const MaterialColor primaryMaterial =
      MaterialColor(_primaryValue, <int, Color>{
        50: Color(0xFFF3E5F5),
        100: Color(0xFFE1BEE7),
        200: Color(0xFFCE93D8),
        300: Color(0xFFBA68C8),
        400: Color(0xFFAB47BC),
        500: Color(_primaryValue),
        600: Color(0xFF8E24AA),
        700: Color(0xFF7B1FA2),
        800: Color(0xFF6A1B9A),
        900: Color(0xFF4A148C),
      });
  static const int _primaryValue = 0xFF7C3AED;

  static const MaterialColor primaryAccent =
      MaterialColor(_primaryAccentValue, <int, Color>{
        100: Color(0xFFEA80FC),
        200: Color(_primaryAccentValue),
        400: Color(0xFFD500F9),
        700: Color(0xFFAA00FF),
      });
  static const int _primaryAccentValue = 0xFFE040FB;
}
