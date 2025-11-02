import 'package:flutter/material.dart';
import 'package:quazaa/screens/signin.dart';
import 'package:quazaa/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Signin(),
    );
  }
}
