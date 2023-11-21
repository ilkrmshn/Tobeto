import 'package:expenseapp/pages/main_page.dart';
import 'package:flutter/material.dart';

ColorScheme lightColorsScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorsScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: lightColorsScheme.onPrimaryContainer,
          foregroundColor: lightColorsScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: lightColorsScheme.onPrimaryContainer,
          elevation: 10,
          clipBehavior: Clip.antiAlias,
          shadowColor: Colors.grey,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              displayLarge:
                  const TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              displayMedium:
                  const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              bodyLarge: const TextStyle(fontSize: 16.0),
              bodyMedium: const TextStyle(fontSize: 14.0),
              labelLarge:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              titleMedium: const TextStyle(fontSize: 14),
              titleSmall: const TextStyle(fontSize: 12),
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: lightColorsScheme.primary,
                fontSize: 16,
              ),
              labelSmall: const TextStyle(
                  fontSize: 10, decoration: TextDecoration.lineThrough),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: lightColorsScheme.onPrimaryContainer,
            backgroundColor: lightColorsScheme.primary,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: lightColorsScheme.primary,
          contentTextStyle:
              TextStyle(color: lightColorsScheme.onSecondaryContainer),
          actionTextColor: lightColorsScheme.onPrimaryContainer,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
      home: MainPage(),
    ),
  );
}
