import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/student_repository.dart';

class TrackingCubit extends Cubit<bool> {
  final repo;
  DateTime? start;

  TrackingCubit(this.repo) : super(false);

  void startTrack() {
    start = DateTime.now();
    emit(true);
  }

  void finish(int index) {
    if (start == null) return;

    repo.addSession(index, {
      'start': start!.toIso8601String(),
      'end': DateTime.now().toIso8601String(),
    });

    start = null;
    emit(false);
  }
}
