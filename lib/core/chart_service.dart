import 'package:fl_chart/fl_chart.dart';

class ChartService {
  static List<FlSpot> build(Map student) {
    Map<int, double> map = {};

    for (var s in student['sessions'] ?? []) {
      DateTime start = DateTime.parse(s['start']);
      DateTime end = DateTime.parse(s['end']);

      int steps = (end.difference(start).inMinutes / 5).ceil();

      for (int i = 0; i < steps; i++) {
        int key = start.add(Duration(minutes: i * 5)).minute;
        map[key] = (map[key] ?? 0) + 1;
      }
    }

    return List.generate(
      60,
      (i) => FlSpot(i.toDouble(), map[i] ?? 0),
    );
  }
}
