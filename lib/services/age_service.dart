import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/age_model.dart';

class AgeService {
  Future<AgeModel?> predictAge(String name) async {
    try {
      final response =
          await http.get(Uri.parse('https://api.agify.io/?name=$name'));
      if (response.statusCode == 200) {
        return AgeModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      throw Exception('Error al conectar con la API de Agify.');
    }
    return null;
  }
}
