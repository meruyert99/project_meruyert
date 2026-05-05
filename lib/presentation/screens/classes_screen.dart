import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  final box = Hive.box('classesBox');

  void addClass() {
    box.add({'name': 'Class ${box.length + 1}', 'students': []});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Classes")),

      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, _) {
          final classes = box.values.toList();

          return ListView.builder(
            itemCount: classes.length,
            itemBuilder: (_, i) {
              final c = classes[i];

              return ListTile(
                title: Text(c['name']),
                trailing: const Icon(Icons.arrow_forward),

                onTap: () {
                  final key = box.keyAt(i);
                  context.push('/students/$key');
                },
              );
            },
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