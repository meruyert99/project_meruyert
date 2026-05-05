import 'package:hive/hive.dart';

class StudentRepository {
  Box get box => Hive.box('studentsBox');

  List<Map> getStudents() {
    if (box.isEmpty) return [];

    final classItem = Map<String, dynamic>.from(box.getAt(0));
    return List<Map>.from(classItem['students'] ?? []);
  }

  void addStudent(String name) {
    if (box.isEmpty) {
      box.add({
        "name": "Class 1",
        "students": []
      });
    }

    final classItem = Map<String, dynamic>.from(box.getAt(0));
    final students = List<Map>.from(classItem['students'] ?? []);

    students.add({
      "name": name,
      "activities": []
    });

    classItem['students'] = students;
    box.putAt(0, classItem);
  }

  void deleteStudent(int index) {
    final classItem = Map<String, dynamic>.from(box.getAt(0));
    final students = List<Map>.from(classItem['students'] ?? []);

    students.removeAt(index);

    classItem['students'] = students;
    box.putAt(0, classItem);
  }

  void addActivity(int index) {
    final classItem = Map<String, dynamic>.from(box.getAt(0));
    final students = List<Map>.from(classItem['students'] ?? []);

    final student = Map<String, dynamic>.from(students[index]);
    final activities = List<String>.from(student['activities'] ?? []);

    activities.add(DateTime.now().toIso8601String());

    student['activities'] = activities;
    students[index] = student;

    classItem['students'] = students;
    box.putAt(0, classItem);
  }
}