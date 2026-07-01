import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../widgets/main_drawer.dart';
import '../services/pokemon_service.dart';
import '../models/pokemon_model.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final TextEditingController _controller = TextEditingController();
  final PokemonService _pokemonService = PokemonService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  PokemonModel? _pokemonInfo;
  bool _isLoading = false;
  String _error = '';

  void _search() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = '';
      _pokemonInfo = null;
    });

    try {
      final result = await _pokemonService.getPokemon(name);
      if (result != null) {
        setState(() {
          _pokemonInfo = result;
        });
      } else {
        setState(() {
          _error = 'Pokémon no encontrado.';
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _playCry() async {
    if (_pokemonInfo?.cryUrl != null && _pokemonInfo!.cryUrl.isNotEmpty) {
      await _audioPlayer.play(UrlSource(_pokemonInfo!.cryUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Este Pokémon no tiene un sonido oficial disponible.')),
      );
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon'),
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Nombre del Pokémon',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _search(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _search,
                    child: const Icon(Icons.search),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_error.isNotEmpty)
                Text(_error, style: const TextStyle(color: Colors.red))
              else if (_pokemonInfo != null)
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        if (_pokemonInfo!.imageUrl.isNotEmpty)
                          Image.network(
                            _pokemonInfo!.imageUrl,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        Text(
                          _pokemonInfo!.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text('Exp. Base', style: TextStyle(color: Colors.grey)),
                                Text('${_pokemonInfo!.baseExperience}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Altura', style: TextStyle(color: Colors.grey)),
                                Text('${_pokemonInfo!.height} m',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Peso', style: TextStyle(color: Colors.grey)),
                                Text('${_pokemonInfo!.weight} kg',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Habilidades:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Wrap(
                          spacing: 8.0,
                          children: _pokemonInfo!.abilities
                              .map((ability) => Chip(label: Text(ability)))
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _playCry,
                          icon: const Icon(Icons.volume_up),
                          label: const Text('Reproducir Sonido'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            foregroundColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
