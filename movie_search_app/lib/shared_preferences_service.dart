import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String favoritesKey = 'favorites';

  static Future<void> saveMovie(dynamic movie) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var favoriteMovies = prefs.getStringList(favoritesKey) ?? [];

    // Avoid duplicates
    final movieJson = json.encode(movie);
    if (!favoriteMovies.contains(movieJson)) {
      favoriteMovies.add(movieJson);
      await prefs.setStringList(favoritesKey, favoriteMovies);
    }
  }

  static Future<List<dynamic>> getFavoriteMovies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoriteMovies = prefs.getStringList(favoritesKey) ?? [];
    return favoriteMovies.map((movie) => json.decode(movie)).toList();
  }
}
