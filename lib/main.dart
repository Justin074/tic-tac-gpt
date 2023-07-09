import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_gpt/core/enums/theme.dart';
import 'package:tic_tac_gpt/core/providers/theme_provider.dart';
import 'package:tic_tac_gpt/core/styles/dark_theme.dart';
import 'package:tic_tac_gpt/core/styles/light_theme.dart';
import 'package:tic_tac_gpt/lib/widgets/tic_tac_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeProvider themeProvider;

  @override
  void initState() {
    themeProvider = ThemeProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ColorScheme>(
      valueListenable: themeProvider.valueProvider,
      builder: (BuildContext context, ColorScheme value, Widget? child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(),
            colorScheme: value,
          ),
          home: Builder(
            builder: (context) {
              return Scaffold(
                backgroundColor: Theme.of(context).colorScheme.primary,
                appBar: AppBar(
                  title: Text(
                    'TIC TAC GPT',
                    style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  elevation: 0,
                  actions: <Widget>[
                    IconButton(
                      splashRadius: 1,
                      onPressed: () {
                        if (themeProvider.currentTheme == CurrentTheme.light) {
                          themeProvider.updateTheme(
                            DarkTheme.colorScheme,
                            CurrentTheme.dark,
                          );
                        } else {
                          themeProvider.updateTheme(
                            LightTheme.colorScheme,
                            CurrentTheme.light,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.dark_mode_outlined,
                        color: Theme.of(context).colorScheme.surface,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                body: const TicTacGrid(),
              );
            },
          ),
        );
      },
    );
  }
}
