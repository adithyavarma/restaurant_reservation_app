import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'main.dart'; // your actual MyApp widget

Future<void> main() async {
  await dotenv.load(fileName: ".env.development");
  runApp(const MyApp());
}