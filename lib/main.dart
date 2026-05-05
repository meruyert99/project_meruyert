import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_router.dart';
import 'domain/repositories/student_repository.dart';
import 'presentation/bloc/students_cubit.dart';
import 'presentation/bloc/tracking_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('studentsBox');

  final prefs = await SharedPreferences.getInstance();
  final loggedIn = prefs.getBool('loggedIn') ?? false;

  runApp(MyApp(loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;

  const MyApp({super.key, required this.loggedIn});

  @override
  Widget build(BuildContext context) {
    final repo = StudentRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => StudentsCubit(repo),
        ),
        BlocProvider(
          create: (_) => TrackingCubit(repo),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router(loggedIn),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        ),
      ),
    );
  }
}
