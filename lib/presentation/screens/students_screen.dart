import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/students_cubit.dart';
import '../models/student.dart';
import '../services/export_service.dart';

class StudentsScreen extends StatefulWidget {
  final int classIndex;

  const StudentsScreen({
    super.key,
    required this.classIndex,
  });

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final searchController = TextEditingController();
  String query = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // 📤 EXPORT
  void _exportData(BuildContext context) async {
    final students = context.read<StudentsCubit>().state;

    final path = await ExportService.export(students);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("CSV saved: $path")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students (class ${widget.classIndex})'),

        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: "Export CSV",
            onPressed: () => _exportData(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Reset all activities",
            onPressed: () => _confirmResetAll(context),
          ),
        ],
      ),

      body: Column(
        children: [
          // 🔍 SEARCH
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search student...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  query = value.toLowerCase();
                });
              },
            ),
          ),

          // 📋 LIST
          Expanded(
            child: BlocBuilder<StudentsCubit, List<Student>>(
              builder: (context, students) {
                final filtered = students.where((s) {
                  return s.name.toLowerCase().contains(query);
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text("No students"));
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final student = filtered[index];
                    final originalIndex = students.indexOf(student);

                    return ListTile(
                      title: Text(student.name),

                      subtitle:
                          Text('Activity: ${student.activities.length}'),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              context
                                  .read<StudentsCubit>()
                                  .addActivity(originalIndex);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _confirmDelete(context, originalIndex);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      // ➕ ADD STUDENT
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // ➕ ADD STUDENT
  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Student"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isEmpty) return;

              context.read<StudentsCubit>().addStudent(text);

              searchController.clear();
              setState(() => query = '');

              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  // 🗑 DELETE
  void _confirmDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete student"),
        content: const Text("Are you sure?"),
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

  // 🔄 RESET ALL
  void _confirmResetAll(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Reset all activities"),
        content: const Text("This will clear ALL students activities. Continue?"),
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
              context.read<StudentsCubit>().resetAllActivities();
              Navigator.pop(context);
            },
            child: const Text("Reset"),
          ),
        ],
      ),
    );
  }
}