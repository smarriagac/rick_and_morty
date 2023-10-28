import 'dart:math' as math;

import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  bool get darkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }

  /// [router]: global alias router
  NavigatorState get router => Navigator.of(this);

  /// [textTheme] : texto global dle tema
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// [color] : accede a los colores del tema
  ColorScheme get color => Theme.of(this).colorScheme;

  /// [CLASE RESPONSIVA]
  Size get sz => MediaQuery.of(this).size;

  /// Ancho de la pantalla
  double get wd => sz.width;

  /// Alto de la pantalla
  double get hg => sz.height;

  double get diagonal {
    final diagonal = math.sqrt(
      math.pow(sz.width, 2) + math.pow(sz.height, 2),
    );
    return diagonal;
  }

  /// `Altura`
  ///
  /// hp : reporna el valor en pixeles el ancho de la pantalla,
  /// [percent] :  es el pocentaje el cual se quiere retornar (0 a 100).
  double wp(double percent) {
    return percent * wd / 100;
  }

  /// `Altura`
  ///
  /// hp : reporna el valor en pixeles la altura de la pantalla,
  /// [percent] :  es el pocentaje el cual se quiere retornar (0 a 100).
  double hp(double percent) {
    return percent * hg / 100;
  }

  /// `Diagonal`
  ///
  /// dp : reporna el valor en pixeles la diagonal de la pantalla,
  /// [percent] :  es el pocentaje el cual se quiere retornar (0 a 100).
  double dp(double percent) {
    return percent * diagonal / 100;
  }
}
