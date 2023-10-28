import 'package:flutter/material.dart';
import 'package:flutter_2023_it4785/root.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await [Permission.phone, Permission.locationWhenInUse].request();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find My Location',
      home: Root(),
    );
  }
}
