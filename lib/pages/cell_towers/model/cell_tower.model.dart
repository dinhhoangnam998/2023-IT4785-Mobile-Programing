import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

part 'cell_tower.model.freezed.dart';
part 'cell_tower.model.g.dart';

@freezed
class CellTower extends ClusterItem with _$CellTower {
  CellTower._();

  factory CellTower(
      {required int id,
      required int cellId,
      required int lac,
      required int mnc,
      required int mcc,
      required double lat,
      required double long,
      required int networkType,
      required int radiusInMeters}) = _CellTower;
  factory CellTower.fromJson(Map<String, dynamic> json) =>
      _$CellTowerFromJson(json);

  @override
  LatLng get location => LatLng(lat, long);
}
