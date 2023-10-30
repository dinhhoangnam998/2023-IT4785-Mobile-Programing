import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/model/cell_tower.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cell_towers_state.dart';
part 'cell_towers_cubit.freezed.dart';

String kStorageKey = 'cellTowers';

class CellTowersCubit extends Cubit<CellTowersState> {
  CellTowersCubit() : super(const CellTowersState.initial());

  Future<void> loadCellTower(context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String cellTowersString = prefs.getString(kStorageKey) ??
          await DefaultAssetBundle.of(context)
              .loadString("assets/data/cell_info.json");
      List<dynamic> cellTowersJson = jsonDecode(cellTowersString);
      List<CellTower> cellTowers = cellTowersJson
          .map<CellTower>((item) => CellTower.fromJson(item))
          .toList();
      emit(CellTowersState.loaded(cellTowers));
    } catch (e) {
      emit(CellTowersState.error(e.toString()));
    }
  }

  Future<void> deleteCellTower(int index) async {
    try {
      state.maybeWhen(
        orElse: () {},
        loaded: (cellTowers) async {
          var newCellTowers = List.of(cellTowers)..removeAt(index);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          // await prefs.setString(kStorageKey, jsonEncode(newCellTowers));
          emit(CellTowersState.loaded(newCellTowers));
        },
      );
    } catch (e) {
      emit(CellTowersState.error(e.toString()));
    }
  }
}
