import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/screens/login_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/classes_screen.dart';
import 'presentation/screens/charts_screen.dart';
import 'presentation/screens/students_screen.dart';

final router = GoRouter(
  initialLocation: '/login',

  redirect: (context, state) async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('loggedIn') ?? false;

    final isLogin = state.uri.path == '/login';

    if (!loggedIn && !isLogin) return '/login';
    if (loggedIn && isLogin) return '/home';

    return null;
  },

  routes: [
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginScreen(),
    ),

    GoRoute(
      path: '/home',
      builder: (_, __) => const HomeScreen(),
    ),

    GoRoute(
      path: '/classes',
      builder: (_, __) => const ClassesScreen(),
    ),

    GoRoute(
      path: '/charts',
      builder: (_, __) => const ChartsScreen(),
    ),

    GoRoute(
      path: '/students/:id',
      builder: (_, state) => StudentsScreen(
        classIndex: int.parse(state.pathParameters['id']!),
      ),
    ),
  ],
);