import 'package:go_router/go_router.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/students_screen.dart';
import 'presentation/screens/charts_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/students', builder: (_, __) => const StudentsScreen()),
    GoRoute(path: '/charts', builder: (_, __) => const ChartsScreen()),
  ],
);
