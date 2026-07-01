import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import '../services/age_service.dart';
import '../models/age_model.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final TextEditingController _controller = TextEditingController();
  final AgeService _ageService = AgeService();

  AgeModel? _ageInfo;
  bool _isLoading = false;
  String _error = '';

  void _predict() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = '';
      _ageInfo = null;
    });

    try {
      final result = await _ageService.predictAge(name);
      setState(() {
        _ageInfo = result;
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

  Widget _buildAgeCategory() {
    if (_ageInfo == null) return const SizedBox.shrink();

    String category = '';
    IconData icon = Icons.person;
    Color color = Colors.grey;

    if (_ageInfo!.age < 18) {
      category = 'Joven';
      icon = Icons.child_care;
      color = Colors.green;
    } else if (_ageInfo!.age < 60) {
      category = 'Adulto';
      icon = Icons.person;
      color = Colors.blue;
    } else {
      category = 'Anciano';
      icon = Icons.elderly;
      color = Colors.purple;
    }

    return Column(
      children: [
        Icon(icon, size: 100, color: color),
        const SizedBox(height: 20),
        Text(
          category,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predicción de Edad'),
        centerTitle: true,
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
              ),
              onSubmitted: (_) => _predict(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predict,
              child: const Text('Predecir Edad'),
            ),
            const SizedBox(height: 40),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red))
            else if (_ageInfo != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Text(
                        'Edad estimada: ${_ageInfo!.age}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      _buildAgeCategory(),
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
