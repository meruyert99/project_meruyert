import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsCubit extends Cubit<List> {
  final repo;

  StudentsCubit(this.repo) : super([]);

  void load() {
    final data = repo.getStudents();
    emit(data);
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
