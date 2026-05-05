class LessonController {
  static final LessonController instance = LessonController._();

  LessonController._();

  DateTime? lessonStartTime;
  DateTime? lessonEndTime;

  bool get isRunning =>
      lessonStartTime != null && lessonEndTime == null;

  void start() {
    lessonStartTime = DateTime.now();
    lessonEndTime = null;
  }

  void stop() {
    lessonEndTime = DateTime.now();
  }

  void reset() {
    lessonStartTime = null;
    lessonEndTime = null;
  }
}