import 'package:flutter/material.dart';
import 'shared_preferences_service.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: SafeArea(
        child: Container(
          width: double.infinity, // Use double.infinity to fill the width
          height: double.infinity, // Use double.infinity to fill the height
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1B7b2cu9yRG5OG6jvRdG7eoD-1FMsoT-WIzunimqQHv507kqi9aJfmTDsOiFwcBjO2T8&usqp=CAU',
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 15, top: 15),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black.withOpacity(
                          0.5), // Add background to enhance text visibility
                    ),
                    child: const Text(
                      'Favorites',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // Center text horizontally
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
              Expanded(
                // Use Expanded to fill the remaining space
                child: FutureBuilder<List<dynamic>>(
                  future: SharedPreferencesService.getFavoriteMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No favorite movies found.'));
                    }

                    final favorites = snapshot.data!;

                    return ListView.builder(
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final movie = favorites[index];

                        return ListTile(
                          leading: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                              )
                              // Height for movie poster
                            ],
                          ),
                          title: Text(movie['title']),
                          subtitle: Text(movie['release_date']),
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
