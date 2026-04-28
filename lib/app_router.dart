import 'package:go_router/go_router.dart';

import 'presentation/screens/login_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/students_screen.dart';
import 'presentation/screens/search_screen.dart';
import 'presentation/screens/charts_screen.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),
    GoRoute(path: '/home', builder: (c, s) => const HomeScreen()),
    GoRoute(path: '/students', builder: (c, s) => const StudentsScreen()),
    GoRoute(path: '/search', builder: (c, s) => const SearchScreen()),
    GoRoute(path: '/charts', builder: (c, s) => const ChartsScreen()),
  ],
);