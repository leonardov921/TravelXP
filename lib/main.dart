import 'package:flutter/material.dart';
//import 'package:flutter_application_travelxp/home_screen.dart';
import 'package:flutter_application_travelxp/login_screen.dart'; // Ajusta la ruta según tu estructura de carpetas

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelXP',
      checkerboardRasterCacheImages: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          const LoginScreen(), // Asegúrate de que esta sea tu pantalla principal
    );
  }
}
