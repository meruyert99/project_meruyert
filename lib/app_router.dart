import 'package:go_router/go_router.dart';

import 'presentation/screens/login_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/classes_screen.dart';
import 'presentation/screens/students_screen.dart';
import 'presentation/screens/charts_screen.dart';
import 'presentation/screens/lesson_screen.dart';

GoRouter router(bool loggedIn) {
  return GoRouter(
    initialLocation: loggedIn ? '/home' : '/login',

    redirect: (context, state) {
      final isLogin = state.uri.path == '/login';

      if (!loggedIn && !isLogin) return '/login';
      if (loggedIn && isLogin) return '/home';

      return null;
    },

    routes: [
      // 🔐 LOGIN
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),

      // 🏠 HOME
      GoRoute(
        path: '/home',
        builder: (_, __) => const HomeScreen(),
      ),

      // 📚 CLASSES
      GoRoute(
        path: '/classes',
        builder: (_, __) => const ClassesScreen(),
      ),

      // 👥 STUDENTS
      GoRoute(
        path: '/students/:id',
        builder: (_, state) => StudentsScreen(
          classIndex: int.parse(state.pathParameters['id']!),
        ),
      ),

      // ⏱ LESSON
      GoRoute(
        path: '/lesson/:id',
        builder: (_, state) => LessonScreen(
          classIndex: int.parse(state.pathParameters['id']!),
        ),
      ),

      // 📊 CHARTS
      GoRoute(
        path: '/charts',
        builder: (_, __) => const ChartsScreen(),
      ),
    ],
  );
}
