import 'package:flutter/material.dart';
import 'package:tic_tac_gpt/core/styles/styles.dart';

class DarkTheme {
  static ColorScheme get colorScheme => const ColorScheme.dark(
        primary: Styles.backgroundColorDark,
        secondary: Styles.upperShadowColorDark,
        tertiary: Styles.lowerShadowColorDark,
        surface: Colors.grey,
      );
}
