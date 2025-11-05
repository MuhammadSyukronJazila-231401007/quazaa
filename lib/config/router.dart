import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/splash.dart';
import '../screens/signin.dart';
import '../screens/home.dart';
import '../screens/settings.dart';
import '../screens/leaderboard.dart';
import '../screens/quiz_screen.dart';
import '../screens/result_screen.dart';
import '../widgets/main_shell.dart';

/// Kelas konstanta biar path gak typo
class AppRoutes {
  static const splash = '/';
  static const signin = '/signin';
  static const home = '/home';
  static const settings = '/settings';
  static const leaderboard = '/leaderboard';
  static const quiz = '/quiz';
  static const result = '/result';
}

GoRouter createRouter() {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      // Halaman Splash
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Halaman Sign In
      GoRoute(
        path: AppRoutes.signin,
        name: 'signin',
        builder: (context, state) => const Signin(),
      ),

      // Rute dengan Bottom Navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          // Branch Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // Branch Settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),

          // Branch Leaderboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.leaderboard,
                name: 'leaderboard',
                builder: (context, state) => const LeaderboardScreen(),
              ),
            ],
          ),
        ],
      ),

      // Halaman Quiz
      GoRoute(
        path: AppRoutes.quiz,
        name: 'quiz',
        builder: (context, state) {
          final quizName = state.uri.queryParameters['name'] ?? 'Flutter Quiz';
          final totalStr = state.uri.queryParameters['count'] ?? '15';
          final total = int.tryParse(totalStr) ?? 15;
          return QuizScreen(quizName: quizName, totalQuestions: total);
        },
      ),

      // Halaman Result
      GoRoute(
        path: AppRoutes.result,
        name: 'result',
        builder: (context, state) => const ResultScreen(),
      ),
    ],

    // Error Page
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            const Text("404 - Halaman Tidak Ditemukan"),
            Text("Path: ${state.uri.path}"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text("Kembali ke Home"),
            ),
          ],
        ),
      ),
    ),
  );
}
