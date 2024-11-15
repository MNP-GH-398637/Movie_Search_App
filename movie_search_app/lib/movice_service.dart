import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  static const String apiKey =
      '72fc6acb9361f062a12ce4d12b9e5cf3'; // Replace with your TMDb API key
  static const String apiUrl = 'https://api.themoviedb.org/3/search/movie';

  static Future<List<dynamic>> searchMovies(String query) async {
    final response =
        await http.get(Uri.parse('$apiUrl?api_key=$apiKey&query=$query'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      return decodedData['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
