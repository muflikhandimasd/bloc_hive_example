import 'package:bloc_hive_example/hive_database/hive_database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/movie.dart';

part './movie_event.dart';
part './movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final HiveDatabase hiveDatabase;
  MovieBloc({required this.hiveDatabase}) : super(MovieLoading()) {
    on<LoadMovies>(_onLoadMovies);
    on<AddMovie>(_onAddMovie);
    on<UpdateMovie>(_onUpdateMovie);
    on<DeleteMovie>(_onDeleteMovie);
    on<DeleteAllMovies>(_onDeleteAllMovies);
  }

  void _onLoadMovies(LoadMovies event, Emitter<MovieState> emit) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    Box box = await hiveDatabase.openBox();
    List<Movie> movies = hiveDatabase.getMovies(box);
    emit(MovieLoaded(movies: movies));
  }

  void _onUpdateMovie(UpdateMovie event, Emitter<MovieState> emit) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    Box box = await hiveDatabase.openBox();
    if (state is MovieLoaded) {
      await hiveDatabase.updateMovie(box, event.movie);
      List<Movie> movies = hiveDatabase.getMovies(box);
      emit(MovieLoaded(movies: movies));
    }
  }

  void _onAddMovie(AddMovie event, Emitter<MovieState> emit) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    Box box = await hiveDatabase.openBox();
    if (state is MovieLoaded) {
      await hiveDatabase.addMovie(box, event.movie);
      List<Movie> movies = hiveDatabase.getMovies(box);
      emit(MovieLoaded(movies: movies));
    }
  }

  void _onDeleteMovie(DeleteMovie event, Emitter<MovieState> emit) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    Box box = await hiveDatabase.openBox();
    if (state is MovieLoaded) {
      await hiveDatabase.deleteMovie(box, event.movie);
      List<Movie> movies = hiveDatabase.getMovies(box);
      emit(MovieLoaded(movies: movies));
    }
  }

  void _onDeleteAllMovies(
      DeleteAllMovies event, Emitter<MovieState> emit) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    Box box = await hiveDatabase.openBox();
    if (state is MovieLoaded) {
      await hiveDatabase.deleteAllMovie(box);
      List<Movie> movies = hiveDatabase.getMovies(box);
      emit(MovieLoaded(movies: movies));
    }
  }
}
