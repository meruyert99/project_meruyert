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

  Map get currentClass => box.getAt(widget.classIndex);

  List get students => currentClass['students'];

  void addStudent() {
    students.add({'name': 'Student ${students.length + 1}', 'activities': []});
    box.putAt(widget.classIndex, currentClass);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(currentClass['name'])),

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
