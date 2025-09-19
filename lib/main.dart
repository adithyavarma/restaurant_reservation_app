import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  const envFile = String.fromEnvironment('ENV_FILE', defaultValue: '.env.dev');
  await dotenv.load(fileName: envFile);
  runApp(MyApp(homeScreen: HomePage()));
}

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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Welcome!')),
    );
  }
}
