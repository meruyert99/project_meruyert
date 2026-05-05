import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  final box = Hive.box('studentsBox');

  int selectedStudentIndex = 0;

  List<Map> get students {
    if (box.isEmpty) return [];

    final classItem = Map<String, dynamic>.from(box.getAt(0));
    return List<Map>.from(classItem['students'] ?? []);
  }

  List<FlSpot> buildChart(List activities) {
    Map<int, double> map = {};

    for (var item in activities) {
      final dt = DateTime.tryParse(item.toString());
      if (dt == null) continue;

      map[dt.hour] = (map[dt.hour] ?? 0) + 1;
    }

    return List.generate(
      24,
      (i) => FlSpot(i.toDouble(), map[i] ?? 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (students.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Нет учеников")),
      );
    }

    final student = students[selectedStudentIndex];
    final activities = student['activities'] ?? [];

    final data = buildChart(activities);

    return Scaffold(
      appBar: AppBar(
        title: const Text("📊 Аналитика"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              value: selectedStudentIndex,
              items: List.generate(
                students.length,
                (i) => DropdownMenuItem(
                  value: i,
                  child: Text(students[i]['name']),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  selectedStudentIndex = val ?? 0;
                });
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: LineChart(
                LineChartData(
                  minY: 0,
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: data,
                      isCurved: true,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Всего активностей: ${activities.length}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}