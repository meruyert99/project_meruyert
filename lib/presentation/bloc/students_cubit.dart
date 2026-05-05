import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class StudentsCubit extends Cubit<List<Map>> {
  final Box box = Hive.box('studentsBox');

  StudentsCubit() : super([]) {
    loadStudents();
  }

  // 📦 LOAD FROM HIVE
  void loadStudents() {
    if (box.isEmpty) {
      emit([]);
      return;
    }

    final data = Map<String, dynamic>.from(box.getAt(0));
    final students = List<Map>.from(data['students'] ?? []);

    emit(students);
  }

  // ➕ ADD STUDENT
  void addStudent(String name) {
    final updated = [
      ...state,
      {
        'name': name,
        'activities': [],
      }
    ];

    _save(updated);
  }

  // ❌ DELETE STUDENT
  void deleteStudent(int index) {
    final updated = [...state]..removeAt(index);

    _save(updated);
  }

  // ⏱ ADD ACTIVITY
  void addActivity(int index) {
    final updated = [...state];

    final student = updated[index];

    final activities = List<String>.from(student['activities'] ?? []);

    activities.add(DateTime.now().toIso8601String());

    updated[index] = {
      ...student,
      'activities': activities,
    };

    _save(updated);
  }

  // 🔄 RESET ALL ACTIVITIES
  void resetAllActivities() {
    final updated = state.map((student) {
      return {
        ...student,
        'activities': [],
      };
    }).toList();

    _save(updated);
  }

  // 💾 SINGLE SOURCE OF TRUTH (IMPORTANT)
  void _save(List<Map> updated) {
    emit(updated);

    box.putAt(0, {
      'students': updated,
    });
  }
}