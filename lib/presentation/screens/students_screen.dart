import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/students_cubit.dart';

class StudentsScreen extends StatelessWidget {
  final int classIndex;

  const StudentsScreen({
    super.key,
    required this.classIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students (class $classIndex)'),
      ),

      body: BlocBuilder<StudentsCubit, List<Map>>(
        builder: (context, students) {
          if (students.isEmpty) {
            return const Center(
              child: Text("No students"),
            );
          }

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final s = students[index];

              return ListTile(
                title: Text(s['name']),
                subtitle: Text('Activity: ${s['activity']}'),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ➕ increase activity
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        context.read<StudentsCubit>().addActivity(index);
                      },
                    ),

                    // 🗑 delete with confirmation
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _confirmDelete(context, index);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      // ➕ add student
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // ---------------- ADD STUDENT ----------------
  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Student"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter name",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context
                    .read<StudentsCubit>()
                    .addStudent(controller.text);
              }
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  // ---------------- DELETE STUDENT ----------------
  void _confirmDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete student"),
        content: const Text("Are you sure you want to delete this student?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              context.read<StudentsCubit>().deleteStudent(index);
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}