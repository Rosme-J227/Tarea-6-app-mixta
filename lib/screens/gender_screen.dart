import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import '../services/gender_service.dart';
import '../models/gender_model.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final TextEditingController _controller = TextEditingController();
  final GenderService _genderService = GenderService();

  GenderModel? _genderInfo;
  bool _isLoading = false;
  String _error = '';

  void _predict() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = '';
      _genderInfo = null;
    });

    try {
      final result = await _genderService.predictGender(name);
      setState(() {
        _genderInfo = result;
      });
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

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.white;
    if (_genderInfo != null) {
      if (_genderInfo!.gender == 'male') {
        bgColor = Colors.blue.shade100;
      } else if (_genderInfo!.gender == 'female') {
        bgColor = Colors.pink.shade100;
      }
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Predicción de Género'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ingresa un nombre',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white70,
              ),
              onSubmitted: (_) => _predict(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predict,
              child: const Text('Predecir Género'),
            ),
            const SizedBox(height: 40),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red))
            else if (_genderInfo != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Nombre: ${_genderInfo!.name}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Género: ${_genderInfo!.gender}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Probabilidad: ${(_genderInfo!.probability * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
