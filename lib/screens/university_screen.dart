import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/main_drawer.dart';
import '../services/university_service.dart';
import '../models/university_model.dart';

class UniversityScreen extends StatefulWidget {
  const UniversityScreen({super.key});

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  final TextEditingController _controller = TextEditingController();
  final UniversityService _universityService = UniversityService();

  List<UniversityModel> _universities = [];
  bool _isLoading = false;
  String _error = '';

  void _search() async {
    final country = _controller.text.trim();
    if (country.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = '';
      _universities = [];
    });

    try {
      final results = await _universityService.getUniversities(country);
      setState(() {
        _universities = results;
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

  Future<void> _launchURL(String urlString) async {
    if (urlString.isEmpty) return;
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir $urlString')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidades'),
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'País en inglés (ej. Dominican Republic)',
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
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(_error, style: const TextStyle(color: Colors.red)),
            )
          else if (_universities.isEmpty)
            const Expanded(
              child: Center(
                child: Text('Busca un país para ver sus universidades.'),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: _universities.length,
                itemBuilder: (context, index) {
                  final uni = _universities[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 15),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      title: Text(
                        uni.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text('Dominio: ${uni.domain}'),
                          const SizedBox(height: 5),
                          Text('Sitio Web: ${uni.webPage}',
                              style: const TextStyle(color: Colors.blue)),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.open_in_browser, color: Colors.blueGrey),
                        onPressed: () => _launchURL(uni.webPage),
                        tooltip: 'Visitar',
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
