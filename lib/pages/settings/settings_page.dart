import 'package:flutter/material.dart';

// initial position
// stopClusteringZoom
// .withOpacity(0.15 * tel.signalStrengthLevel));
// ripple duration

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("SettingsPage"),
    );
  }
}
