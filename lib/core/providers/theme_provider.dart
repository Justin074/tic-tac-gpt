import 'package:flutter/material.dart';
import 'package:tic_tac_gpt/core/enums/theme.dart';
import 'package:tic_tac_gpt/core/providers/base_provider.dart';
import 'package:tic_tac_gpt/core/styles/light_theme.dart';

class ThemeProvider extends BaseProvider<ColorScheme> {
  ThemeProvider() : super(classCreator: () => LightTheme.colorScheme);
  CurrentTheme currentTheme = CurrentTheme.light;

  void updateTheme(ColorScheme colorScheme, CurrentTheme newTheme) {
    valueProvider.value = colorScheme;
    currentTheme = newTheme;
    notifyClients();
  }
}
