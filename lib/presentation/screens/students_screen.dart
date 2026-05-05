import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/students_cubit.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students (class ${widget.classIndex})'),
      ),

      body: Column(
        children: [
          // 🔍 SEARCH FIELD
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
            child: BlocBuilder<StudentsCubit, List<Map>>(
              builder: (context, students) {
                // 🔍 FILTER
                final filtered = students.where((s) {
                  final name = (s['name'] ?? '').toLowerCase();
                  return name.contains(query);
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(
                    child: Text("No students"),
                  );
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final s = filtered[index];

                    return ListTile(
                      title: Text(s['name']),
                      subtitle: Text('Activity: ${s['activity']}'),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              final originalIndex =
                                  students.indexOf(s); // 👈 важно!
                              context
                                  .read<StudentsCubit>()
                                  .addActivity(originalIndex);
                            },
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              final originalIndex =
                                  students.indexOf(s);
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

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // ADD
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
                context.read<StudentsCubit>().addStudent(controller.text);
              }
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  // DELETE
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
}