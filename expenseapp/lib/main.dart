import 'package:flutter/material.dart';
import 'package:expenseapp/pages/main_page.dart';

// Single Responsibility
void main() {
  runApp(
    MaterialApp(theme: ThemeData(useMaterial3: true), home: const MainPage()),
  );
}
