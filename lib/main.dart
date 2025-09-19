import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  final Widget homeScreen;
  

  const MyApp({super.key, required this.homeScreen});

  @override
  Widget build(BuildContext context) {
    final envName = dotenv.env['ENV_NAME'] ?? "Unknown";
    return MaterialApp(
      title: "Restaurant Reservation System - ($envName)",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: homeScreen,
    );
  }
}
