import 'package:flutter/material.dart';
import 'package:flutter_2023_it4785/app.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/cubit/cell_towers_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CellTowersCubit(),
      child: App(),
    );
  }
}
