import 'package:freezed_annotation/freezed_annotation.dart';

part 'cell_tower.model.freezed.dart';
part 'cell_tower.model.g.dart';

@freezed
class CellTower with _$CellTower {
  const factory CellTower(
      {required int id,
      required int cellId,
      required int lac,
      required int mnc,
      required int mcc,
      required double long,
      required double lat,
      required int networkType,
      required int radiusInMeters}) = _CellTower;
  factory CellTower.fromJson(Map<String, dynamic> json) =>
      _$CellTowerFromJson(json);
}
