import 'package:flutter/material.dart';
import 'package:flutter_2023_it4785/pages/cell_towers_page.dart';
import 'package:flutter_2023_it4785/pages/map_page.dart';
import 'package:flutter_2023_it4785/pages/settings_page.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentIndex = 0;
  final List _pages = [MapPage(), CellTowersPage(), SettingsPage()];

  void updateCurrentIndex(newValue) {
    setState(() {
      _currentIndex = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find My Location App'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(
              icon: Icon(Icons.cell_tower), label: "Cell Towers"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
        currentIndex: _currentIndex,
        onTap: (value) {
          updateCurrentIndex(value);
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
