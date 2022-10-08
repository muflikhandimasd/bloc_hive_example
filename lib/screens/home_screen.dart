import 'dart:math';

import 'package:bloc_hive_example/bloc/movie/movie_bloc.dart';
import 'package:bloc_hive_example/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favorite Movies'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<MovieBloc>().add(DeleteAllMovies());
              },
              icon: Icon(Icons.clear_rounded))
        ],
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MovieLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                Movie movie = state.movies[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  leading: Image.network(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                    width: 100,
                  ),
                  title: Text(movie.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<MovieBloc>().add(UpdateMovie(
                              movie: movie.copyWith(
                                  addedToWatchList: !movie.addedToWatchList)));
                        },
                        icon: Icon(
                          Icons.watch_later_sharp,
                          color: movie.addedToWatchList
                              ? Colors.grey
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _showModalBottomSheet(context: context, movie: movie);
                        },
                        icon: Icon(
                          Icons.edit,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<MovieBloc>()
                              .add(DeleteMovie(movie: movie));
                        },
                        icon: Icon(
                          Icons.delete,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showModalBottomSheet(context: context);
        },
      ),
    );
  }

  void _showModalBottomSheet({required BuildContext context, Movie? movie}) {
    Random random = Random();
    TextEditingController nameController = TextEditingController();
    TextEditingController imageUrlController = TextEditingController();
    if (movie != null) {
      nameController.text = movie.name;
      imageUrlController.text = movie.imageUrl;
    }

    showModalBottomSheet(
      context: context,
      isDismissible: true,
      elevation: 5,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(labelText: 'Movie'),
            ),
            TextField(
              controller: imageUrlController,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (movie != null) {
                  context.read<MovieBloc>().add(UpdateMovie(
                      movie: movie.copyWith(
                          name: nameController.text,
                          imageUrl: imageUrlController.text)));
                } else {
                  Movie movie = Movie(
                      id: '${random.nextInt(10000)}',
                      name: nameController.text,
                      imageUrl: imageUrlController.text,
                      addedToWatchList: false);

                  context.read<MovieBloc>().add(AddMovie(movie: movie));
                }

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
