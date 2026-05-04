import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app_router.dart';
import 'data/repositories/student_repository.dart';
import 'presentation/bloc/student_cubit.dart';
import 'presentation/bloc/tracking_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('studentsBox');

  final repo = StudentRepository();

  runApp(MyApp(repo));
}

class MyApp extends StatelessWidget {
  final StudentRepository repo;
  const MyApp(this.repo, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => StudentCubit(repo)),
        BlocProvider(create: (_) => TrackingCubit(repo)),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        ),
      ),
    );
  }
}
