import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'providers/quiz_result_provider.dart';
import 'providers/user_provider.dart';
import 'config/router.dart'; 

void main() {
  final router = createRouter(); 

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizResultProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()..loadFromPrefs()),
      ],
      child: QuazaaApp(router: router),
    ),
  );
}

class QuazaaApp extends StatelessWidget {
  final GoRouter router;
  const QuazaaApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Quazaa App',
      theme: ThemeData(
        fontFamily: 'Rubik',
        scaffoldBackgroundColor: const Color(0xFFF0ECE6),
      ),
      routerConfig: router,
    );
  }
}
