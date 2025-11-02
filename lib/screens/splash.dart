import 'package:flutter/material.dart';
import 'signin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Signin()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF0ECE6),
      body: Center(
        child: Text(
          'QUAZAA',
          style: TextStyle(
            fontFamily: 'Doggybag',
            fontSize: 48,
            color: Color(0xFF001833),
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
