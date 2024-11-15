import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:movie_search_app/movice_service.dart';
import 'package:movie_search_app/movie_datail_screen.dart';

import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _movies = [];

  void _searchMovies() async {
    final results = await MovieService.searchMovies(_searchController.text);
    setState(() {
      _movies = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 300,
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1B7b2cu9yRG5OG6jvRdG7eoD-1FMsoT-WIzunimqQHv507kqi9aJfmTDsOiFwcBjO2T8&usqp=CAU'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 15, top: 15),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 20,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: const Text(
                      'SVS CINEMAS',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: "Search for a movie",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _searchMovies,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _movies.length,
                  itemBuilder: (context, index) {
                    final movie = _movies[index];
                    return ListTile(
                      leading: Image.network(
                        'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                        fit: BoxFit.cover,
                      ),
                      title: Text(movie['title']),
                      subtitle: Text(movie['release_date']),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(movie: movie),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
