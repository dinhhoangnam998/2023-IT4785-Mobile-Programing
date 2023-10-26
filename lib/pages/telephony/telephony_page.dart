import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_telephony_info/flutter_telephony_info.dart';

class TelephonyPage extends StatefulWidget {
  const TelephonyPage({super.key});

  @override
  State<TelephonyPage> createState() => _TelephonyPageState();
}

class _TelephonyPageState extends State<TelephonyPage> {
  final _flutterTelephonyInfoPlugin = TelephonyAPI();
  List<TelephonyInfo?>? telephonyInfo;

  Future<void> getTelephonyInfos() async {
    try {
      telephonyInfo = await _flutterTelephonyInfoPlugin.getInfo();

      print(telephonyInfo?.length);
      print(telephonyInfo?.first?.displayName);
    } on PlatformException catch (e) {
      telephonyInfo = null;
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getTelephonyInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: getTelephonyInfos, child: Text('Click me!')),
    );
  }
}
