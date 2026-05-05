import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/screens/login_screen.dart';
import 'presentation/screens/home_screen.dart';

// временные экраны (если у тебя их нет — скажешь, сделаем)
import 'presentation/screens/classes_screen.dart';
import 'presentation/screens/charts_screen.dart';
import 'presentation/screens/students_screen.dart';

late final SharedPreferences prefs;

final router = GoRouter(
  initialLocation: '/login',

  redirect: (context, state) {
    final loggedIn = prefs.getBool('loggedIn') ?? false;
    final goingToLogin = state.uri.path == '/login';

    if (!loggedIn && !goingToLogin) return '/login';
    if (loggedIn && goingToLogin) return '/home';

    return null;
  },

  routes: [
    // AUTH
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginScreen(),
    ),

    // HOME
    GoRoute(
      path: '/home',
      builder: (_, __) => const HomeScreen(),
    ),

    // CLASSES
    GoRoute(
      path: '/classes',
      builder: (_, __) => const ClassesScreen(),
    ),

    // CHARTS
    GoRoute(
      path: '/charts',
      builder: (_, __) => const ChartsScreen(),
    ),

    // STUDENTS (dynamic route)
   GoRoute(
  path: '/students/:id',
  builder: (context, state) {
    final id = state.pathParameters['id'];

    final index = int.tryParse(id ?? '0') ?? 0;

    return StudentsScreen(classIndex: index);
  },
),


  ],
);
