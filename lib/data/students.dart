class Student {
  String name;
  int activity;

  Student({required this.name, this.activity = 0});

  Map<String, dynamic> toMap() {
    return {'name': name, 'activity': activity};
  }

  static Student fromMap(Map data) {
    return Student(
      name: data['name'],
      activity: data['activity'],
    );
  }
}