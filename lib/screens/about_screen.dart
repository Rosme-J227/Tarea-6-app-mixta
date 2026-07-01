import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/main_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('No se pudo abrir $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de Mí'),
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/iconoApp.png'),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.verified, color: Colors.blue, size: 30),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Rosmeris Jimenez Cruz',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Desarrolladora de Software',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 30),
              
              const Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Soy una apasionada por el desarrollo de software y la tecnología. '
                    'Me encanta aprender nuevas herramientas y construir aplicaciones '
                    'que resuelvan problemas del mundo real de manera eficiente y con '
                    'una excelente experiencia de usuario.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              ListTile(
                leading: const Icon(Icons.email, color: Colors.redAccent),
                title: const Text('Correo Electrónico'),
                subtitle: const Text('20241779@itla.edu.do'),
                onTap: () => _launchURL('mailto:20241779@itla.edu.do'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.code, color: Colors.black),
                title: const Text('GitHub'),
                subtitle: const Text('github.com/Rosme-J227'),
                onTap: () => _launchURL('https://github.com/Rosme-J227'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.work, color: Colors.blue),
                title: const Text('LinkedIn'),
                subtitle: const Text('linkedin.com/in/rosmeris-jimenez-227685409'),
                onTap: () => _launchURL('https://www.linkedin.com/in/rosmeris-jimenez-227685409'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
