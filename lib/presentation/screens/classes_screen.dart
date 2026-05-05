import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:go_router/go_router.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  final box = Hive.box('classesBox');

  List get classes => box.values.toList();

  void addClass() {
    box.add({'name': 'Class ${classes.length + 1}', 'students': []});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Classes")),
      body: ListView.builder(
        itemCount: classes.length,
        itemBuilder: (_, i) {
          final c = classes[i];
          return ListTile(
            title: Text(c['name']),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => context.push('/students/$i'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addClass,
        child: const Icon(Icons.add),
      ),
    );
  }
}
