import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/gender_screen.dart';
import '../screens/age_screen.dart';
import '../screens/university_screen.dart';
import '../screens/weather_screen.dart';
import '../screens/pokemon_screen.dart';
import '../screens/news_screen.dart';
import '../screens/about_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.build_circle, color: Colors.white, size: 48),
                SizedBox(height: 10),
                Text(
                  'Toolbox App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.male),
            title: const Text('Predicción de género'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const GenderScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.cake),
            title: const Text('Predicción de edad'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AgeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Universidades'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const UniversityScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.cloud),
            title: const Text('Clima RD'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WeatherScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.catching_pokemon),
            title: const Text('Pokémon'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PokemonScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.article),
            title: const Text('Noticias WordPress'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const NewsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Acerca de'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
