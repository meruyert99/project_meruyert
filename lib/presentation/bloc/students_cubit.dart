import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/student_repository.dart';

class StudentCubit extends Cubit<List> {
  final repo;
  StudentCubit(this.repo) : super([]) {
    load();
  }

  void load() => emit(repo.getAll());

  void add(String name) {
    repo.add(name);
    load();
  }

  void delete(int i) {
    repo.delete(i);
    load();
  }
}
