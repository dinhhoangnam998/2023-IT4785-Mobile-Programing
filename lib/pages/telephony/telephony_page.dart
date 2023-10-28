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
  List<TelephonyInfo?>? _telInfoList;
  String? errorMessage;

  Future<void> getTelephonyInfos() async {
    try {
      _telInfoList = await _flutterTelephonyInfoPlugin.getInfo();
      // setState(() {
      //   // _telInfoList = telInfoList;
      // });
      // print('Length ${telInfoList?.length}');
      // TelephonyInfo? tel = telInfoList?.first;
      // if (tel != null) {
      //   String telephonyInfo =
      //       'cellId: ${tel.cellId};\n displayName: ${tel.displayName};\n mobileNetworkCode: ${tel.mobileNetworkCode};\n networkGeneration: ${tel.networkGeneration};\n radioType: ${tel.radioType};\n cellSignalStrength: ${tel.cellSignalStrength}';
      //   setState(() {
      //     // _telephonyInfoString = telephonyInfo;
      //   });
      //   print('cellId: ${tel.cellId}');
      //   print('displayName: ${tel.displayName}');
      //   print('mobileNetworkCode: ${tel.mobileNetworkCode}');
      //   print('networkGeneration: ${tel.networkGeneration}');
      //   print('radioType: ${tel.radioType}');
      //   print('cellSignalStrength: ${tel.cellSignalStrength}');
      // }
      // print(telephonyInfo?.first);
    } on PlatformException catch (e) {
      _telInfoList = null;
      errorMessage = e.toString();
      print(e);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTelephonyInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: getTelephonyInfos, child: Text('Get Cells Info')),
        errorMessage == null ? Text('') : Text(errorMessage!),
        Expanded(
          child: _telInfoList == null
              ? Text('Cannot get telephony infos')
              : ListView.builder(
                  itemCount: _telInfoList!.length,
                  itemBuilder: (_, index) {
                    TelephonyInfo? telInfo = _telInfoList![index];
                    if (telInfo == null) return Text('null');
                    String telephonyInfo =
                        'cellId: ${telInfo.cellId};\n displayName: ${telInfo.displayName};\n mobileNetworkCode: ${telInfo.mobileNetworkCode};\n networkGeneration: ${telInfo.networkGeneration};\n radioType: ${telInfo.radioType};\n cellSignalStrength: ${telInfo.cellSignalStrength}';
                    return ListTile(title: Text(telephonyInfo));
                  }),
        )
      ],
    ));
  }
}
