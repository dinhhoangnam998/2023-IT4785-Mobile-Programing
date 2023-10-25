import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/model/cell_tower.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cell_towers_state.dart';
part 'cell_towers_cubit.freezed.dart';

class CellTowersCubit extends Cubit<CellTowersState> {
  CellTowersCubit() : super(CellTowersState.initial());

  Future<void> loadCellTower(context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String cellTowersString = prefs.getString('cellTowers') ??
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
}
