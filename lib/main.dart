import 'package:bloc_hive_example/hive_database/hive_database.dart';
import 'package:bloc_hive_example/models/movie.dart';
import 'package:bloc_hive_example/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
