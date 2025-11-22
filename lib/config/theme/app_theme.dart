// appTheme.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/core/constants/my_string.dart';

abstract class AppTheme {
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  static ThemeData light() => ThemeData(
    useMaterial3: true,
    visualDensity: visualDensity,
    primaryColor: MyColor.primary,
    scaffoldBackgroundColor: MyColor.surface,
    cardColor: MyColor.surfaceContainer,
    iconTheme: IconThemeData(color: MyColor.onSurfaceVariant),
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: MyColor.onSurfaceVariant, size: 20.w),
      backgroundColor: MyColor.surface,
      titleTextStyle: TextStyle(
        color: MyColor.onSurface,
        fontSize: 16.sp,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: MyColor.primary,
      onPrimary: MyColor.onPrimary,
      primaryContainer: MyColor.primaryContainer,
      onPrimaryContainer: MyColor.onPrimaryContainer,
      secondary: MyColor.secondary,
      onSecondary: MyColor.onSecondary,
      secondaryContainer: MyColor.secondaryContainer,
      onSecondaryContainer: MyColor.onSecondaryContainer,
      tertiary: MyColor.secondary, // Using secondary as tertiary
      onTertiary: MyColor.onSecondary,
      tertiaryContainer: MyColor.secondaryContainer,
      onTertiaryContainer: MyColor.onSecondaryContainer,
      error: MyColor.error,
      onError: MyColor.onPrimary,
      errorContainer: MyColor.errorContainer,
      onErrorContainer: MyColor.onErrorContainer,
      surface: MyColor.surface,
      onSurface: MyColor.onSurface,
      surfaceContainerHighest: MyColor.surfaceContainerHigh,
      onSurfaceVariant: MyColor.onSurfaceVariant,
      outline: MyColor.outline,
      outlineVariant: MyColor.outlineVariant,
      shadow: MyColor.black,
      scrim: MyColor.black,
      inverseSurface: MyColor.darkSurface,
      onInverseSurface: MyColor.darkOnSurface,
      inversePrimary: MyColor.primaryFixedDim,
      surfaceTint: MyColor.primary,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: MyColor.onSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        color: MyColor.onSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: MyColor.onSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: MyColor.onSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: MyColor.onSurface,
        fontSize: 16.sp,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: MyColor.onSurfaceVariant,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: MyColor.onSurface,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: MyColor.onSurface,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 10.sp,
        color: MyColor.onSurfaceVariant,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp,
        color: MyColor.onSurfaceVariant,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        color: MyColor.onSurfaceVariant,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp,
        color: MyColor.outline,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize: 14.sp,
        color: MyColor.onSurfaceVariant,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        fontSize: 14.sp,
        color: MyColor.outline,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      filled: true,
      prefixIconColor: MyColor.outline,
      fillColor: MyColor.surfaceContainerLowest,
      contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(13.5.r)),
        borderSide: BorderSide(color: MyColor.primary, width: 1.5.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(13.5.r)),
        borderSide: BorderSide(color: MyColor.outlineVariant, width: 1.0.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(13.5.r)),
        borderSide: BorderSide(color: MyColor.error, width: 1.5.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(13.5.r)),
        borderSide: BorderSide(color: MyColor.error, width: 1.5.w),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.5.r)),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
        ),
        backgroundColor: WidgetStateProperty.all(MyColor.primary),
        foregroundColor: WidgetStateProperty.all(MyColor.onPrimary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 16.sp,
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(MyColor.primary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 14.sp,
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: MyColor.outlineVariant,
      thickness: 1.0.w,
      space: 1.0.h,
    ),
  );

  /// Dark theme and its settings.
  static ThemeData dark() => ThemeData.dark().copyWith(
    visualDensity: visualDensity,
    primaryColor: MyColor.primary,
    scaffoldBackgroundColor: MyColor.darkSurface,
    cardColor: MyColor.darkSurfaceContainer,
    iconTheme: IconThemeData(color: MyColor.darkOnSurfaceVariant),
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: MyColor.darkOnSurfaceVariant, size: 20.w),
      backgroundColor: MyColor.darkSurface,
      titleTextStyle: TextStyle(
        color: MyColor.darkOnSurface,
        fontSize: 16.sp,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: MyColor.primary,
      onPrimary: MyColor.onPrimary,
      primaryContainer: MyColor.primaryContainer,
      onPrimaryContainer: MyColor.onPrimaryContainer,
      secondary: MyColor.darkSurfaceContainerHigh,
      onSecondary: MyColor.darkOnSurface,
      secondaryContainer: MyColor.darkSurfaceContainerHigh,
      onSecondaryContainer: MyColor.darkOnSurface,
      tertiary: MyColor.darkSurfaceContainerHigh,
      onTertiary: MyColor.darkOnSurface,
      tertiaryContainer: MyColor.darkSurfaceContainerHigh,
      onTertiaryContainer: MyColor.darkOnSurface,
      error: MyColor.darkError,
      onError: MyColor.onPrimary,
      errorContainer: MyColor.darkErrorContainer,
      onErrorContainer: MyColor.darkOnErrorContainer,
      surface: MyColor.darkSurface,
      onSurface: MyColor.darkOnSurface,
      surfaceContainerHighest: MyColor.darkSurfaceContainerHigh,
      onSurfaceVariant: MyColor.darkOnSurfaceVariant,
      outline: MyColor.darkOutline,
      outlineVariant: MyColor.darkOutlineVariant,
      shadow: MyColor.black,
      scrim: MyColor.black,
      inverseSurface: MyColor.surface,
      onInverseSurface: MyColor.onSurface,
      inversePrimary: MyColor.primaryFixedDim,
      surfaceTint: MyColor.primary,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: MyColor.darkOnSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        color: MyColor.darkOnSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: MyColor.darkOnSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: MyColor.darkOnSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: MyColor.darkOnSurface,
        fontSize: 16.sp,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: MyColor.darkOnSurfaceVariant,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: MyColor.darkOnSurface,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: MyColor.darkOnSurface,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        color: MyColor.darkOnSurfaceVariant,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp,
        color: MyColor.darkOnSurfaceVariant,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        color: MyColor.darkOnSurfaceVariant,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp,
        color: MyColor.darkOutline,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize: 14.sp,
        color: MyColor.darkOnSurfaceVariant,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        fontSize: 14.sp,
        color: MyColor.darkOutline,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      filled: true,
      prefixIconColor: MyColor.darkOutline,
      fillColor: MyColor.darkSurfaceContainer,
      contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(13.5.r)),
        borderSide: BorderSide(color: MyColor.primary, width: 1.5.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(13.5.r)),
        borderSide: BorderSide(color: MyColor.darkOutlineVariant, width: 1.0.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(13.5.r)),
        borderSide: BorderSide(color: MyColor.darkError, width: 1.5.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(13.5.r)),
        borderSide: BorderSide(color: MyColor.darkError, width: 1.5.w),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.5.r)),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
        ),
        backgroundColor: WidgetStateProperty.all(MyColor.primary),
        foregroundColor: WidgetStateProperty.all(MyColor.onPrimary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 16.sp,
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(MyColor.primary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 14.sp,
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: MyColor.darkOutlineVariant,
      thickness: 1.0.w,
      space: 1.0.h,
    ),
  );
}
