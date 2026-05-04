import 'package:hive/hive.dart';

class StudentRepository {
  final box = Hive.box('studentsBox');

  List getAll() => box.values.toList();

  void add(String name) {
    box.add({'name': name, 'sessions': []});
  }

  void delete(int index) {
    box.deleteAt(index);
  }

  void addSession(int index, Map session) {
    var student = box.getAt(index);
    List sessions = student['sessions'] ?? [];
    sessions.add(session);
    student['sessions'] = sessions;
    box.putAt(index, student);
  }
}
