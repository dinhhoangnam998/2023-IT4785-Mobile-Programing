// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/add_cell_tower_dialog.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/cubit/cell_towers_cubit.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/model/cell_tower.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CellTowersPage extends StatefulWidget {
  const CellTowersPage({super.key});

  @override
  State<CellTowersPage> createState() => _CellTowersPageState();
}

class _CellTowersPageState extends State<CellTowersPage> {
  
  void _openAddDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AddCellDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CellTowersCubit, CellTowersState>(
      builder: (context, state) {
        return state.when(
            initial: () => const Text('Loading cells info'),
            loaded: (cellTowers) => Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  hintText: "Search"),
                            ),
                          ),
                          SizedBox(width: 12),
                          MaterialButton(
                            onPressed: _openAddDialog,
                            color: Colors.green,
                            child: const Icon(Icons.add),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: cellTowers.length,
                            itemBuilder: (_, index) => Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 12,
                                  ),
                                  child: Slidable(
                                    endActionPane: ActionPane(
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (_) {},
                                          icon: Icons.edit,
                                          backgroundColor: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        SlidableAction(
                                          onPressed: (context) {
                                            context
                                                .read<CellTowersCubit>()
                                                .deleteCellTower(index);
                                          },
                                          icon: Icons.delete,
                                          backgroundColor: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        )
                                      ],
                                    ),
                                    child: Container(
                                      // margin: EdgeInsets.only(bottom: 12),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: ListTile(
                                        // dense: true,
                                        isThreeLine: true,
                                        title:
                                            Text(getTitle(cellTowers[index])),
                                        subtitle: Text(
                                            getSubTitle(cellTowers[index])),
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    ],
                  ),
                ),
            error: (message) => Text(message));
      },
    );
  }
}

String getTitle(CellTower cellTower) {
  return 'id: ${cellTower.id}, lac: ${cellTower.lac}, cid: ${cellTower.cellId}';
}

String getSubTitle(CellTower cellTower) {
  return 'lat: ${cellTower.lat}, long: ${cellTower.long}, radius: ${cellTower.radiusInMeters}m\n${getSubSubTitle(cellTower)}';
}

String getSubSubTitle(CellTower cellTower) {
  return 'mcc: ${cellTower.mcc}, mnc: ${cellTower.mcc}, networkType: ${cellTower.networkType}';
}
