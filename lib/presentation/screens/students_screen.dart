import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/student_cubit.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StudentCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text("Students")),

      body: BlocBuilder<StudentCubit, List>(
        builder: (context, students) {
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (_, i) {
              final s = students[i];
              return ListTile(
                title: Text(s['name']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => cubit.delete(i),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => cubit.add("Student ${DateTime.now().second}"),
        child: const Icon(Icons.add),
      ),
    );
  }
}
