// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cell_tower.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CellTower _$CellTowerFromJson(Map<String, dynamic> json) {
  return _CellTower.fromJson(json);
}

/// @nodoc
mixin _$CellTower {
  int get id => throw _privateConstructorUsedError;
  int get cellId => throw _privateConstructorUsedError;
  int get lac => throw _privateConstructorUsedError;
  int get mnc => throw _privateConstructorUsedError;
  int get mcc => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get long => throw _privateConstructorUsedError;
  int get networkType => throw _privateConstructorUsedError;
  int get radiusInMeters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CellTowerCopyWith<CellTower> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CellTowerCopyWith<$Res> {
  factory $CellTowerCopyWith(CellTower value, $Res Function(CellTower) then) =
      _$CellTowerCopyWithImpl<$Res, CellTower>;
  @useResult
  $Res call(
      {int id,
      int cellId,
      int lac,
      int mnc,
      int mcc,
      double lat,
      double long,
      int networkType,
      int radiusInMeters});
}

/// @nodoc
class _$CellTowerCopyWithImpl<$Res, $Val extends CellTower>
    implements $CellTowerCopyWith<$Res> {
  _$CellTowerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cellId = null,
    Object? lac = null,
    Object? mnc = null,
    Object? mcc = null,
    Object? lat = null,
    Object? long = null,
    Object? networkType = null,
    Object? radiusInMeters = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cellId: null == cellId
          ? _value.cellId
          : cellId // ignore: cast_nullable_to_non_nullable
              as int,
      lac: null == lac
          ? _value.lac
          : lac // ignore: cast_nullable_to_non_nullable
              as int,
      mnc: null == mnc
          ? _value.mnc
          : mnc // ignore: cast_nullable_to_non_nullable
              as int,
      mcc: null == mcc
          ? _value.mcc
          : mcc // ignore: cast_nullable_to_non_nullable
              as int,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      long: null == long
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as double,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as int,
      radiusInMeters: null == radiusInMeters
          ? _value.radiusInMeters
          : radiusInMeters // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CellTowerImplCopyWith<$Res>
    implements $CellTowerCopyWith<$Res> {
  factory _$$CellTowerImplCopyWith(
          _$CellTowerImpl value, $Res Function(_$CellTowerImpl) then) =
      __$$CellTowerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int cellId,
      int lac,
      int mnc,
      int mcc,
      double lat,
      double long,
      int networkType,
      int radiusInMeters});
}

/// @nodoc
class __$$CellTowerImplCopyWithImpl<$Res>
    extends _$CellTowerCopyWithImpl<$Res, _$CellTowerImpl>
    implements _$$CellTowerImplCopyWith<$Res> {
  __$$CellTowerImplCopyWithImpl(
      _$CellTowerImpl _value, $Res Function(_$CellTowerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cellId = null,
    Object? lac = null,
    Object? mnc = null,
    Object? mcc = null,
    Object? lat = null,
    Object? long = null,
    Object? networkType = null,
    Object? radiusInMeters = null,
  }) {
    return _then(_$CellTowerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cellId: null == cellId
          ? _value.cellId
          : cellId // ignore: cast_nullable_to_non_nullable
              as int,
      lac: null == lac
          ? _value.lac
          : lac // ignore: cast_nullable_to_non_nullable
              as int,
      mnc: null == mnc
          ? _value.mnc
          : mnc // ignore: cast_nullable_to_non_nullable
              as int,
      mcc: null == mcc
          ? _value.mcc
          : mcc // ignore: cast_nullable_to_non_nullable
              as int,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      long: null == long
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as double,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as int,
      radiusInMeters: null == radiusInMeters
          ? _value.radiusInMeters
          : radiusInMeters // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CellTowerImpl extends _CellTower {
  _$CellTowerImpl(
      {required this.id,
      required this.cellId,
      required this.lac,
      required this.mnc,
      required this.mcc,
      required this.lat,
      required this.long,
      required this.networkType,
      required this.radiusInMeters})
      : super._();

  factory _$CellTowerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CellTowerImplFromJson(json);

  @override
  final int id;
  @override
  final int cellId;
  @override
  final int lac;
  @override
  final int mnc;
  @override
  final int mcc;
  @override
  final double lat;
  @override
  final double long;
  @override
  final int networkType;
  @override
  final int radiusInMeters;

  @override
  String toString() {
    return 'CellTower(id: $id, cellId: $cellId, lac: $lac, mnc: $mnc, mcc: $mcc, lat: $lat, long: $long, networkType: $networkType, radiusInMeters: $radiusInMeters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CellTowerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cellId, cellId) || other.cellId == cellId) &&
            (identical(other.lac, lac) || other.lac == lac) &&
            (identical(other.mnc, mnc) || other.mnc == mnc) &&
            (identical(other.mcc, mcc) || other.mcc == mcc) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.long, long) || other.long == long) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.radiusInMeters, radiusInMeters) ||
                other.radiusInMeters == radiusInMeters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, cellId, lac, mnc, mcc, lat,
      long, networkType, radiusInMeters);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CellTowerImplCopyWith<_$CellTowerImpl> get copyWith =>
      __$$CellTowerImplCopyWithImpl<_$CellTowerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CellTowerImplToJson(
      this,
    );
  }
}

abstract class _CellTower extends CellTower {
  factory _CellTower(
      {required final int id,
      required final int cellId,
      required final int lac,
      required final int mnc,
      required final int mcc,
      required final double lat,
      required final double long,
      required final int networkType,
      required final int radiusInMeters}) = _$CellTowerImpl;
  _CellTower._() : super._();

  factory _CellTower.fromJson(Map<String, dynamic> json) =
      _$CellTowerImpl.fromJson;

  @override
  int get id;
  @override
  int get cellId;
  @override
  int get lac;
  @override
  int get mnc;
  @override
  int get mcc;
  @override
  double get lat;
  @override
  double get long;
  @override
  int get networkType;
  @override
  int get radiusInMeters;
  @override
  @JsonKey(ignore: true)
  _$$CellTowerImplCopyWith<_$CellTowerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
