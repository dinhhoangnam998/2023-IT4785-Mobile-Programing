import 'package:flutter/material.dart';
import 'package:flutter_telephony_info/flutter_telephony_info.dart';

class ParsedTelephonyInfo {
  final TelephonyInfo? rawTelephonyInfo;
  final int mcc;
  final int mnc;
  final int lac;
  final int cellId;
  final int signalStrengthLevel;
  ParsedTelephonyInfo(
      {this.rawTelephonyInfo,
      required this.mcc,
      required this.mnc,
      required this.lac,
      required this.cellId,
      required this.signalStrengthLevel});
}

String parseStringArg(String str, String argName) {
  List<String> parts = str.split(" ");
  try {
    String argPart = parts.where((element) => element.contains(argName)).first;
    String argValue = argPart.split("=")[1];
    return argValue;
  } catch (e) {
    debugPrint(e.toString());
    return "";
  }
}

ParsedTelephonyInfo parseRawTelephonyInfo(TelephonyInfo rawTelephonyInfo) {
  String cellIdentity = rawTelephonyInfo.cellId ?? '';
  String cellSignalStrength = rawTelephonyInfo.cellSignalStrength ?? '';
  String lacString = parseStringArg(cellIdentity, 'mTac');
  if (lacString == '') {
    lacString = parseStringArg(cellIdentity, 'mLac');
  }
  int lac = int.parse(lacString);
  int mcc = int.parse(parseStringArg(cellIdentity, 'mMcc'));
  int mnc = int.parse(parseStringArg(cellIdentity, 'mMnc'));
  int cellId = int.parse(parseStringArg(cellIdentity, 'mCi'));
  int signalStrengthLevel =
      int.parse(parseStringArg(cellSignalStrength, 'level'));
  return ParsedTelephonyInfo(
      rawTelephonyInfo: rawTelephonyInfo,
      mcc: mcc,
      mnc: mnc,
      lac: lac,
      cellId: cellId,
      signalStrengthLevel: signalStrengthLevel);
}
