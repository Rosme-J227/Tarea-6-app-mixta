# Toolbox App — Tarea 6: Aplicaciones Móviles con APIs Públicas

**Matrícula:** 20241779  
**Nombre:** Rosmeris Jimenez Cruz  
**Asignatura:** Introducción al desarrollo de Aplicaciones Móviles  
**Instituto:** ITLA — Instituto Tecnológico de Las Américas  

---

##  Descripción

**Toolbox App** es una aplicación móvil desarrollada en Flutter que reúne varias herramientas útiles conectadas a APIs públicas reales. La aplicación fue desarrollada como parte de la **Tarea 6** del curso, aplicando los conocimientos adquiridos en consumo de APIs REST, manejo de estado, navegación y buenas prácticas de desarrollo en Flutter/Dart.

---

## 🛠️ Herramientas y Tecnologías Usadas

| Herramienta | Descripción |
|---|---|
| **Flutter** | Framework principal para desarrollo móvil multiplataforma |
| **Dart** | Lenguaje de programación utilizado |
| **Material Design 3** | Sistema de diseño para la interfaz de usuario |
| **http** | Para consumo de APIs REST |
| **url_launcher** | Para abrir URLs y correos desde la app |
| **audioplayers** | Para reproducir el sonido oficial de los Pokémon |
| **flutter_launcher_icons** | Para configurar el ícono personalizado de la app |

---

## 🗂️ Arquitectura del Proyecto

El proyecto sigue una arquitectura **Feature First**, organizada de la siguiente manera:

```
lib/
 ├── main.dart
 ├── models/
 │   ├── age_model.dart
 │   ├── gender_model.dart
 │   ├── news_model.dart
 │   ├── pokemon_model.dart
 │   ├── university_model.dart
 │   └── weather_model.dart
 ├── services/
 │   ├── age_service.dart
 │   ├── gender_service.dart
 │   ├── news_service.dart
 │   ├── pokemon_service.dart
 │   ├── university_service.dart
 │   └── weather_service.dart
 ├── screens/
 │   ├── home_screen.dart
 │   ├── gender_screen.dart
 │   ├── age_screen.dart
 │   ├── university_screen.dart
 │   ├── weather_screen.dart
 │   ├── pokemon_screen.dart
 │   ├── news_screen.dart
 │   └── about_screen.dart
 ├── widgets/
 │   └── main_drawer.dart
 └── assets/
     └── images/
```

---

## 📲 Pantallas de la Aplicación

| # | Pantalla | Descripción |
|---|---|---|
| 1 | **Inicio** | Presentación de la app con descripción general |
| 2 | **Predicción de Género** | Predice el género de un nombre usando Genderize API |
| 3 | **Predicción de Edad** | Estima la edad promedio de un nombre usando Agify API |
| 4 | **Universidades** | Lista universidades por país usando una API pública |
| 5 | **Clima** | Consulta el clima de cualquier ciudad del mundo |
| 6 | **Pokémon** | Busca información y escucha el sonido de cualquier Pokémon |
| 7 | **Noticias WordPress** | Muestra las últimas noticias de Delicious Brains |
| 8 | **Acerca de Mí** | Información de contacto y perfil de la desarrolladora |

---

## 🌐 APIs Públicas Utilizadas

| API | URL | Uso |
|---|---|---|
| **Genderize.io** | `https://api.genderize.io` | Predicción de género por nombre |
| **Agify.io** | `https://api.agify.io` | Predicción de edad por nombre |
| **Universities API** | `https://adamix.net/proxy.php` | Lista de universidades por país |
| **Open-Meteo** | `https://api.open-meteo.com` | Clima actual por coordenadas |
| **Open-Meteo Geocoding** | `https://geocoding-api.open-meteo.com` | Conversión de ciudad a coordenadas |
| **PokéAPI** | `https://pokeapi.co/api/v2/pokemon` | Datos e imagen de Pokémon |
| **WordPress REST API** | `https://deliciousbrains.com/wp-json/wp/v2/posts` | Últimas noticias del blog |

---

## 🚀 Cómo Ejecutar el Proyecto

### Requisitos previos
- Flutter SDK instalado (`flutter --version`)
- Android Studio o VS Code con extensión de Flutter
- Un emulador Android o dispositivo físico conectado
- **Developer Mode activado en Windows** (necesario para symlinks de Flutter)

### Pasos

```bash
# 1. Clonar el repositorio
git clone https://github.com/Rosme-J227/toolbox_app.git

# 2. Entrar a la carpeta del proyecto
cd toolbox_app

# 3. Instalar dependencias
flutter pub get

# 4. Ejecutar en modo debug
flutter run

# 5. Generar APK release
flutter build apk --release




*Desarrollado usando Flutter & Dart — ITLA 2026*
