import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/student_repository.dart';

class StudentsCubit extends Cubit<List<Map>> {
  final StudentRepository repo;

  StudentsCubit(this.repo) : super([]) {
    load();
  }

  void load() {
    emit(repo.getStudents());
  }

  void addStudent(String name) {
    repo.addStudent(name);
    load();
  }

  void deleteStudent(int index) {
    try {
      repo.deleteStudent(index);
      load();
    } catch (e) {
      print("DELETE ERROR: $e");
    }
  }

  void addActivity(int index) {
    try {
      repo.addActivity(index);
      load();
    } catch (e) {
      print("ACTIVITY ERROR: $e");
    }
  }
}