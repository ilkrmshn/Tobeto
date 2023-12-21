import 'package:flutter/material.dart';
import 'package:miniblog/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MiniBlog',
      home: Homepage(),
    );
  }
}
