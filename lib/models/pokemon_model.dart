class PokemonModel {
  final String name;
  final String imageUrl;
  final int baseExperience;
  final double height;
  final double weight;
  final List<String> abilities;
  final String cryUrl;

  PokemonModel({
    required this.name,
    required this.imageUrl,
    required this.baseExperience,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.cryUrl,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    var abilitiesList = json['abilities'] as List;
    List<String> abilities =
        abilitiesList.map((a) => a['ability']['name'].toString()).toList();

    return PokemonModel(
      name: json['name'] ?? '',
      imageUrl: json['sprites']['front_default'] ?? '',
      baseExperience: json['base_experience'] ?? 0,
      height: (json['height'] ?? 0).toDouble() / 10,
      weight: (json['weight'] ?? 0).toDouble() / 10,
      abilities: abilities,
      cryUrl: json['cries']['latest'] ?? '',
    );
  }
}
