import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:go_router/go_router.dart';

class StudentsScreen extends StatefulWidget {
  final int classIndex;

  const StudentsScreen({super.key, required this.classIndex});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final box = Hive.box('classesBox');

  Map get currentClass => Map.from(box.getAt(widget.classIndex));

  List get students => List.from(currentClass['students']);

  void addStudent() {
    final updatedStudents = List.from(students);

    updatedStudents.add({
      'name': 'Student ${updatedStudents.length + 1}',
      'activities': []
    });

    final updatedClass = Map.from(currentClass);
    updatedClass['students'] = updatedStudents;

    box.putAt(widget.classIndex, updatedClass);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final current = currentClass;

    return Scaffold(
      appBar: AppBar(title: Text(current['name'])),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (_, i) {
                final s = students[i];
                return ListTile(
                  title: Text(s['name']),
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: () => context.push('/lesson/${widget.classIndex}'),
            child: const Text("Start Lesson"),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addStudent,
        child: const Icon(Icons.add),
      ),
    );
  }
}