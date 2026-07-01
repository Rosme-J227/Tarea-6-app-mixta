import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _controller =
      TextEditingController(text: 'Santo Domingo');

  WeatherModel? _weatherInfo;
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadWeather('Santo Domingo');
  }

  void _loadWeather(String city) async {
    setState(() {
      _isLoading = true;
      _error = '';
      _weatherInfo = null;
    });

    try {
      final result = await _weatherService.getWeather(city: city);
      setState(() {
        _weatherInfo = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  // Formatea la fecha actual en español
  String _getFormattedDate() {
    final now = DateTime.now();
    const meses = [
      '', 'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
    ];
    const dias = [
      '', 'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'
    ];
    final dia = dias[now.weekday];
    return '${dia[0].toUpperCase()}${dia.substring(1)}, ${now.day} de ${meses[now.month]} de ${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima'),
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Campo de búsqueda por ciudad
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Buscar ciudad',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_city),
                      ),
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          _loadWeather(value.trim());
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      final city = _controller.text.trim();
                      if (city.isNotEmpty) {
                        _loadWeather(city);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Icon(Icons.search),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              if (_isLoading)
                const CircularProgressIndicator()
              else if (_error.isNotEmpty)
                Card(
                  color: Colors.red.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if (_weatherInfo != null)
                Column(
                  children: [
                    // Fecha del día
                    Text(
                      _getFormattedDate(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Ciudad
                    Text(
                      _weatherInfo!.city,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Ícono del clima
                    Text(
                      _weatherInfo!.icon,
                      style: const TextStyle(fontSize: 100),
                    ),
                    const SizedBox(height: 10),

                    // Temperatura
                    Text(
                      '${_weatherInfo!.temperature}°C',
                      style: const TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),

                    // Descripción
                    Text(
                      _weatherInfo!.description,
                      style: const TextStyle(
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Detalles: humedad y viento
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Icon(Icons.water_drop,
                                    color: Colors.blue, size: 30),
                                const SizedBox(height: 5),
                                const Text('Humedad',
                                    style: TextStyle(color: Colors.grey)),
                                Text(
                                  '${_weatherInfo!.humidity}%',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            Container(
                              height: 50,
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            Column(
                              children: [
                                const Icon(Icons.air,
                                    color: Colors.blueGrey, size: 30),
                                const SizedBox(height: 5),
                                const Text('Viento',
                                    style: TextStyle(color: Colors.grey)),
                                Text(
                                  '${_weatherInfo!.windSpeed} km/h',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
