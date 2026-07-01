import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/university_model.dart';

class UniversityService {
  Future<List<UniversityModel>> getUniversities(String country) async {
    try {
      final query = country.replaceAll(' ', '+');
      final response = await http.get(
          Uri.parse('https://adamix.net/proxy.php?country=$query'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => UniversityModel.fromJson(json)).toList();
      }
    } catch (e) {
      throw Exception('Error al conectar con la API de Universidades.');
    }
    return [];
  }
}
