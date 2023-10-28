import 'package:flutter/material.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/cell_towers_page.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/cubit/cell_towers_cubit.dart';
import 'package:flutter_2023_it4785/pages/map_gps/map_gps_page.dart';
import 'package:flutter_2023_it4785/pages/map_tel/map_tel_page.dart';
import 'package:flutter_2023_it4785/pages/settings/settings_page.dart';
import 'package:flutter_2023_it4785/pages/telephony/telephony_page.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  final List _pages = const [
    MapTelPage(),
    MapGPSPage(),
    CellTowersPage(),
    SettingsPage(),
    // TelephonyPage()
  ];

  void updateCurrentIndex(newValue) {
    setState(() {
      _currentIndex = newValue;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CellTowersCubit>().loadCellTower(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find My Location'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.black,
        // selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map Tel"),
          BottomNavigationBarItem(
              icon: Icon(Icons.gps_fixed), label: "Map GPS"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Cell Towers"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
          // BottomNavigationBarItem(icon: Icon(Icons.phone), label: "Telephony"),
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
