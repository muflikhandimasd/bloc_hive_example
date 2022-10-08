import 'dart:io';

import 'package:bloc_hive_example/bloc/movie/movie_bloc.dart';
import 'package:bloc_hive_example/hive_database/hive_database.dart';
import 'package:bloc_hive_example/models/movie.dart';
import 'package:bloc_hive_example/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final Directory directory = await getApplicationDocumentsDirectory();

  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  final hiveDatabase = HiveDatabase();
  await hiveDatabase.openBox();

  runApp(MyApp(hiveDatabase: hiveDatabase));
}

class MyApp extends StatelessWidget {
  final HiveDatabase _hiveDatabase;
  MyApp({Key? key, required HiveDatabase hiveDatabase})
      : _hiveDatabase = hiveDatabase,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => _hiveDatabase,
      child: BlocProvider(
        create: (context) =>
            MovieBloc(hiveDatabase: _hiveDatabase)..add(LoadMovies()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}
