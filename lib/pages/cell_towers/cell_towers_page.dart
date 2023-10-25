import 'package:flutter/material.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/cubit/cell_towers_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CellTowersPage extends StatefulWidget {
  const CellTowersPage({super.key});

  @override
  State<CellTowersPage> createState() => _CellTowersPageState();
}

class _CellTowersPageState extends State<CellTowersPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CellTowersCubit, CellTowersState>(
      builder: (context, state) {
        return state.when(
            initial: () => const Text('Loading cells info'),
            loaded: (cellTowers) => ListView.builder(
                itemCount: cellTowers.length,
                itemBuilder: (_, index) => ListTile(
                      title: Text(cellTowers[index].toString()),
                    )),
            error: (message) => Text(message));
      },
    );
  }
}
