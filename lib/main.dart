import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sartia_global_assignment/bloc/notes_bloc.dart';
import 'package:sartia_global_assignment/data/provider_data/notes_provider.dart';
import 'package:sartia_global_assignment/data/repo/notes_repo.dart';
import 'package:sartia_global_assignment/mainscreen.dart';

import 'model/notes_model.dart';
import 'tap_drawer_screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NotesModelAdapter());
  await readFromHive();
  runApp(const MyApp());
}

// Future<Iterable<Map<String, dynamic>>> readFromHive() async {
//   final box = await Hive.openBox('myBox');
//   final result = box.values.cast<Map<String, dynamic>>();
//   return result;
// }
readFromHive() async {
  final box = await Hive.openBox('myBox');
  // final result = box.values.cast<Map<String, dynamic>>();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NotesBloc(NotesRepo(NotesProvider()))),
      ],
      child: MaterialApp(
        title: 'Sartia Global',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
