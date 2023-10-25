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
  int get cellId => throw _privateConstructorUsedError;
  int get lac => throw _privateConstructorUsedError;
  int get mnc => throw _privateConstructorUsedError;
  int get mcc => throw _privateConstructorUsedError;
  double get long => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  int get networkType => throw _privateConstructorUsedError;

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
      {int cellId,
      int lac,
      int mnc,
      int mcc,
      double long,
      double lat,
      int networkType});
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
    Object? cellId = null,
    Object? lac = null,
    Object? mnc = null,
    Object? mcc = null,
    Object? long = null,
    Object? lat = null,
    Object? networkType = null,
  }) {
    return _then(_value.copyWith(
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
      long: null == long
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as double,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
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
      {int cellId,
      int lac,
      int mnc,
      int mcc,
      double long,
      double lat,
      int networkType});
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
    Object? cellId = null,
    Object? lac = null,
    Object? mnc = null,
    Object? mcc = null,
    Object? long = null,
    Object? lat = null,
    Object? networkType = null,
  }) {
    return _then(_$CellTowerImpl(
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
      long: null == long
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as double,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CellTowerImpl implements _CellTower {
  const _$CellTowerImpl(
      {required this.cellId,
      required this.lac,
      required this.mnc,
      required this.mcc,
      required this.long,
      required this.lat,
      required this.networkType});

  factory _$CellTowerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CellTowerImplFromJson(json);

  @override
  final int cellId;
  @override
  final int lac;
  @override
  final int mnc;
  @override
  final int mcc;
  @override
  final double long;
  @override
  final double lat;
  @override
  final int networkType;

  @override
  String toString() {
    return 'CellTower(cellId: $cellId, lac: $lac, mnc: $mnc, mcc: $mcc, long: $long, lat: $lat, networkType: $networkType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CellTowerImpl &&
            (identical(other.cellId, cellId) || other.cellId == cellId) &&
            (identical(other.lac, lac) || other.lac == lac) &&
            (identical(other.mnc, mnc) || other.mnc == mnc) &&
            (identical(other.mcc, mcc) || other.mcc == mcc) &&
            (identical(other.long, long) || other.long == long) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cellId, lac, mnc, mcc, long, lat, networkType);

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

abstract class _CellTower implements CellTower {
  const factory _CellTower(
      {required final int cellId,
      required final int lac,
      required final int mnc,
      required final int mcc,
      required final double long,
      required final double lat,
      required final int networkType}) = _$CellTowerImpl;

  factory _CellTower.fromJson(Map<String, dynamic> json) =
      _$CellTowerImpl.fromJson;

  @override
  int get cellId;
  @override
  int get lac;
  @override
  int get mnc;
  @override
  int get mcc;
  @override
  double get long;
  @override
  double get lat;
  @override
  int get networkType;
  @override
  @JsonKey(ignore: true)
  _$$CellTowerImplCopyWith<_$CellTowerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
