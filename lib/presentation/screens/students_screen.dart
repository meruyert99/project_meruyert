import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final box = Hive.box('studentsBox');

  List get students => box.values.toList();

  void addActivity(int index) {
    var student = students[index];
    student['activity'] += 1;

    box.putAt(index, student);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Students")),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final s = students[index];

          return ListTile(
            title: Text(s['name']),
            subtitle: Text("Activity: ${s['activity']}"),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => addActivity(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          box.add({'name': 'Student ${students.length + 1}', 'activity': 0});
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}