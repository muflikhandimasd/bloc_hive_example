import 'dart:math';

import 'package:bloc_hive_example/models/movie.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Movie> movies = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favorite Movies'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.clear_rounded))
        ],
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          Movie movie = movies[index];
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.watch_later_sharp,
                    color: movie.addedToWatchList
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
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
                Movie movie = Movie(
                    id: '${random.nextInt(10000)}',
                    name: nameController.text,
                    imageUrl: imageUrlController.text,
                    addedToWatchList: false);
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
