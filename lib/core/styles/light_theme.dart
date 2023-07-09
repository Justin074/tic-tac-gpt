import 'package:flutter/material.dart';
import 'package:tic_tac_gpt/core/styles/styles.dart';

class LightTheme {
  static ColorScheme get colorScheme => const ColorScheme.light(
        primary: Styles.backgroundColor,
        secondary: Styles.upperShadowColor,
        tertiary: Styles.lowerShadowColor,
        surface: Colors.black,
      );
}
