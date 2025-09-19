import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/login_screen.dart';
import 'main.dart';

Future<void> main() async {
  // Load the .env.dev file
  await dotenv.load(fileName: ".env.staging");

  runApp(
    const MyApp(
      homeScreen: LoginScreen(),
    ),
  );
}