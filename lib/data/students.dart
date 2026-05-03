import 'session_model.dart';

class Student {
  final String name;
  final List<Session> sessions;

  Student({required this.name, required this.sessions});

  factory Student.fromMap(Map map) => Student(
        name: map['name'],
        sessions: (map['sessions'] as List? ?? [])
            .map((e) => Session.fromMap(e))
            .toList(),
      );
}
