import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/gender_model.dart';

class GenderService {
  Future<GenderModel?> predictGender(String name) async {
    try {
      final response =
          await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
      if (response.statusCode == 200) {
        return GenderModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      throw Exception('Error al conectar con la API de Genderize.');
    }
    return null;
  }
}
