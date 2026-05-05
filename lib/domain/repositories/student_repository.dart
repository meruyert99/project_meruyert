import 'package:hive/hive.dart';

class StudentRepository {
  Box get box => Hive.box('studentsBox');

  List<Map> getStudents() {
    return box.values
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  void addStudent(String name) {
    box.add({'name': name, 'activity': 0});
  }

  void deleteStudent(int index) {
    box.deleteAt(index);
  }

  void addActivity(int index) {
    final student = Map<String, dynamic>.from(box.getAt(index));
    student['activity'] = (student['activity'] ?? 0) + 1;
    box.putAt(index, student);
  }
}