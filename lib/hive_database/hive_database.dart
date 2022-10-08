import 'package:bloc_hive_example/models/movie.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  final String boxName = 'favorite_movies';

  Future<Box> openBox() async {
    Box box = await Hive.openBox<Movie>(boxName);
    return box;
  }

  List<Movie> getMovies(Box box) {
    return box.values.toList().cast<Movie>();
  }

  Future<void> addMovie(Box box, Movie movie) async {
    await box.put(movie.id, movie);
  }

  Future<void> updateMovie(Box box, Movie movie) async {
    await box.put(movie.id, movie);
  }

  Future<void> deleteMovie(Box box, Movie movie) async {
    await box.delete(movie.id);
  }

  Future<void> deleteAllMovie(Box box) async {
    await box.clear();
  }
}
