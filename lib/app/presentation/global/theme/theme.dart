import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_color.dart';
import 'app_textsyle.dart';

ThemeData getTheme(bool darkMode) {
  final AppTextStyle textStyle = AppTextStyle.instance;

  if (darkMode) {
    final darkTheme = ThemeData.dark();
    final textTheme = darkTheme.textTheme;
    const textStyleColor = TextStyle(color: Colors.white);
    return darkTheme.copyWith(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        elevation: 0,
      ),
      colorScheme: colorSchemeDark,
      textTheme: GoogleFonts.nunitoSansTextTheme(
        textTheme.copyWith(
          displayLarge: textStyle.displayLarge.merge(textStyleColor),
          displayMedium: textStyle.displayMedium.merge(textStyleColor),
          displaySmall: textStyle.displaySmall.merge(textStyleColor),
          headlineLarge: textStyle.headlineLarge.merge(textStyleColor),
          headlineMedium: textStyle.headlineMedium.merge(textStyleColor),
          headlineSmall: textStyle.headlineSmall.merge(textStyleColor),
          titleLarge: textStyle.titleLarge.merge(textStyleColor),
          titleSmall: textStyle.titleSmall.merge(textStyleColor),
          titleMedium: textStyle.titleMedium.merge(textStyleColor),
          labelLarge: textStyle.labelLarge.merge(textStyleColor),
          labelMedium: textStyle.labelMedium.merge(textStyleColor),
          labelSmall: textStyle.labelSmall.merge(textStyleColor),
          bodyLarge: textStyle.bodyLarge.merge(textStyleColor),
          bodyMedium: textStyle.bodyMedium.merge(textStyleColor),
          bodySmall: textStyle.bodySmall.merge(textStyleColor),
        ),
      ),
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all(
          Colors.lightBlue.withOpacity(0.5),
        ),
        thumbColor: MaterialStateProperty.all(
          Colors.blue,
        ),
      ),
    );
  }

  final ligthTheme = ThemeData.light();
  final textTheme = ligthTheme.textTheme;

  return ligthTheme.copyWith(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    colorScheme: colorSchemeLight,
    textTheme: GoogleFonts.nunitoSansTextTheme(
      textTheme.copyWith(
        displayLarge: textStyle.displayLarge,
        displayMedium: textStyle.displayMedium,
        displaySmall: textStyle.displaySmall,
        headlineLarge: textStyle.headlineLarge,
        headlineMedium: textStyle.headlineMedium,
        headlineSmall: textStyle.headlineSmall,
        titleLarge: textStyle.titleLarge,
        titleSmall: textStyle.titleSmall,
        titleMedium: textStyle.titleMedium,
        labelLarge: textStyle.labelLarge,
        labelMedium: textStyle.labelMedium,
        labelSmall: textStyle.labelSmall,
        bodyLarge: textStyle.bodyLarge,
        bodyMedium: textStyle.bodyMedium,
        bodySmall: textStyle.bodySmall,
      ),
    ),
  );
}
