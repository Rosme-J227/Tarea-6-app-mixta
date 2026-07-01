import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokemonService {
  Future<PokemonModel?> getPokemon(String name) async {
    try {
      final response = await http
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/${name.toLowerCase()}'));
      if (response.statusCode == 200) {
        return PokemonModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error al conectar con la PokéAPI.');
    }
  }
}
