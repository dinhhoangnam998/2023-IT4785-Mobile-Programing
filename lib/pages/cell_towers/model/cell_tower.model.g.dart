// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cell_tower.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CellTowerImpl _$$CellTowerImplFromJson(Map<String, dynamic> json) =>
    _$CellTowerImpl(
      id: json['id'] as int,
      cellId: json['cellId'] as int,
      lac: json['lac'] as int,
      mnc: json['mnc'] as int,
      mcc: json['mcc'] as int,
      long: (json['long'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      networkType: json['networkType'] as int,
      radiusInMeters: json['radiusInMeters'] as int,
    );

Map<String, dynamic> _$$CellTowerImplToJson(_$CellTowerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cellId': instance.cellId,
      'lac': instance.lac,
      'mnc': instance.mnc,
      'mcc': instance.mcc,
      'long': instance.long,
      'lat': instance.lat,
      'networkType': instance.networkType,
      'radiusInMeters': instance.radiusInMeters,
    };
