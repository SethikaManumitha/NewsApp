import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = '8454dce4765c4d6ca2d1b3a853183fa8';
  static const String _baseUrl = 'https://newsapi.org/v2';

  Future<List<dynamic>> fetchTopNews() async {
    const String url = '$_baseUrl/top-headlines?country=us&apiKey=$_apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['articles'] ?? [];
      } else {
        print('Failed to load news: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching news: $error');
      return [];
    }
  }

  Future<List<dynamic>> fetchNews() async {
      const String url = '$_baseUrl/top-headlines?country=us&apiKey=$_apiKey';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['articles'] ?? [];
      } else {
        return [];
      }
  }
}
