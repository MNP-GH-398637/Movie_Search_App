import 'package:flutter/material.dart';
import 'package:movie_search_app/shared_preferences_service.dart';

class MovieDetailScreen extends StatelessWidget {
  final dynamic movie;

  MovieDetailScreen({required this.movie});

  void _addToFavorites(BuildContext context) async {
    await SharedPreferencesService.saveMovie(movie);
    Navigator.pop(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Added to favorites")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
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
                    child: Column(children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 80, right: 15, top: 15),
                        child: Center(
                          child: Container(
                            width: 300,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text(
                                    movie['title'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.favorite),
                                  onPressed: () => _addToFavorites(context),
                                  color: const Color.fromARGB(255, 59, 60, 62),
                                ),
                              ],
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Image.network(
                                      'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                        'Release Date: ${movie['release_date']}',
                                        style: TextStyle(fontSize: 18)),
                                    SizedBox(height: 1),
                                    Text('Rating: ${movie['vote_average']}',
                                        style: TextStyle(fontSize: 18)),
                                    SizedBox(height: 1),
                                    Text('Synopsis: ${movie['overview']}',
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])))));
  }
}
