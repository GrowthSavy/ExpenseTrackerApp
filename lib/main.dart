import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(100, 22, 250, 189));
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Color.fromARGB(96, 38, 81, 131));

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {});
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      colorScheme: kDarkColorScheme,
      cardTheme: const CardTheme().copyWith(
        color: kDarkColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kDarkColorScheme.onSecondaryContainer,
              fontSize: 17,
            ),
            titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
              color: kDarkColorScheme.onSecondaryContainer,
              fontSize: 15,
            ),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScheme.primaryContainer,
        ),
      ),
    ),
    theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 17,
            ))),
    home: const Expenses(),
  ));
}
