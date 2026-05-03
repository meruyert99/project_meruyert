class Session {
  final DateTime start;
  final DateTime end;

  Session({required this.start, required this.end});

  Map<String, dynamic> toMap() => {
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
      };

  factory Session.fromMap(Map map) => Session(
        start: DateTime.parse(map['start']),
        end: DateTime.parse(map['end']),
      );
}
