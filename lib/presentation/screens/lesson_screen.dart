import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LessonScreen extends StatefulWidget {
  final int classIndex;

  const LessonScreen({super.key, required this.classIndex});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final box = Hive.box('classesBox');

  DateTime? startTime;

  Map get currentClass => box.getAt(widget.classIndex);
  List get students => currentClass['students'];

  void start() {
    startTime = DateTime.now();
    setState(() {});
  }

  void addActivity(int index) {
    final student = students[index];
    List acts = student['activities'] ?? [];

    acts.add(DateTime.now().toIso8601String());

    student['activities'] = acts;

    box.putAt(widget.classIndex, currentClass);
    setState(() {});
  }

  void finish() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lesson")),

      body: Column(
        children: [
          ElevatedButton(
            onPressed: start,
            child: const Text("Start"),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (_, i) {
                final s = students[i];
                return Card(
                  child: ListTile(
                    title: Text(s['name']),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => addActivity(i),
                    ),
                  ),
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: finish,
            child: const Text("Finish"),
          ),
        ],
      ),
    );
  }
}
