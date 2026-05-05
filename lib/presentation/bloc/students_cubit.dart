import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/student_repository.dart';

class StudentsCubit extends Cubit<List<Map>> {
  final StudentRepository repo;

  StudentsCubit(this.repo) : super([]) {
    load();
  }

  void load() {
    final data = repo.getStudents();
    emit(data);
  }
  void resetAllActivities() {
  final updated = state.map((student) {
    return {
      ...student,
      'activities': [],
    };
  }).toList();

  emit(updated);
}
  void addStudent(String name) {
    repo.addStudent(name);
    load();
  }

  void deleteStudent(int index) {
    repo.deleteStudent(index);
    load();
  }

  void addActivity(int index) {
    repo.addActivity(index);
    load();
  }
}