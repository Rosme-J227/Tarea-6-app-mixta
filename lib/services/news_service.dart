import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  Future<List<NewsModel>> getLatestNews() async {
    try {
      final response = await http.get(
          Uri.parse('https://deliciousbrains.com/wp-json/wp/v2/posts?per_page=3'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => NewsModel.fromJson(json)).toList();
      }
    } catch (e) {
      throw Exception('Error al conectar con la API de WordPress.');
    }
    return [];
  }
}
