import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      context.go('/signin');
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
