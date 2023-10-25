import 'package:flutter/material.dart';
import 'package:flutter_2023_it4785/root.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Find My Location',
      home: Root(),
    );
  }
}
