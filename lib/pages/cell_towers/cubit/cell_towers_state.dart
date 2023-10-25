part of 'cell_towers_cubit.dart';

@freezed
class CellTowersState with _$CellTowersState {
  const factory CellTowersState.initial() = _Initial;
  const factory CellTowersState.loaded(List<CellTower> cellTowers) = _Loaded;
  const factory CellTowersState.error(String message) = _Error;
}
