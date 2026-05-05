import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/repositories/student_repository.dart';
import 'presentation/bloc/students_cubit.dart';
import 'app_router.dart';
import 'core/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('studentsBox');
  await Hive.openBox('classesBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => StudentsCubit(StudentRepository()),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeController(),
        child: Consumer<ThemeController>(
          builder: (context, theme, _) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: router,
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              ),
              darkTheme: ThemeData.dark(useMaterial3: true),
              themeMode: theme.themeMode,
            );
          },
        ),
      ),
    );
  }
}