import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  final box = Hive.box('classesBox');

  int selectedClassIndex = 0;
  int selectedStudentIndex = 0;

  List get classes => box.values.toList();

  List get students {
    if (classes.isEmpty) return [];
    return classes[selectedClassIndex]['students'];
  }

  List<FlSpot> buildChart(List activities) {
    Map<int, double> map = {};

    for (var t in activities) {
      final dt = DateTime.parse(t);
      map[dt.minute] = (map[dt.minute] ?? 0) + 1;
    }

    return List.generate(
      60,
      (i) => FlSpot(i.toDouble(), map[i] ?? 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (classes.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Нет данных")),
      );
    }

    final classItem = classes[selectedClassIndex];
    final studentsList = classItem['students'];

    if (studentsList.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Нет учеников")),
      );
    }

    final student = studentsList[selectedStudentIndex];
    final data = buildChart(student['activities'] ?? []);

    return Scaffold(
      appBar: AppBar(title: const Text("Аналитика")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 📚 ВЫБОР КЛАССА
            DropdownButtonFormField(
              value: selectedClassIndex,
              decoration: const InputDecoration(labelText: "Класс"),
              items: List.generate(
                classes.length,
                (i) => DropdownMenuItem(
                  value: i,
                  child: Text(classes[i]['name']),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  selectedClassIndex = val as int;
                  selectedStudentIndex = 0;
                });
              },
            ),

            const SizedBox(height: 12),

            // 👤 ВЫБОР УЧЕНИКА
            DropdownButtonFormField(
              value: selectedStudentIndex,
              decoration: const InputDecoration(labelText: "Ученик"),
              items: List.generate(
                studentsList.length,
                (i) => DropdownMenuItem(
                  value: i,
                  child: Text(studentsList[i]['name']),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  selectedStudentIndex = val as int;
                });
              },
            ),

            const SizedBox(height: 20),

            // 📊 ГРАФИК
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 10,
                            getTitlesWidget: (value, _) =>
                                Text('${value.toInt()}m'),
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true),
                        ),
                      ),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: data,
                          isCurved: true,
                          barWidth: 3,
                          dotData: FlDotData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 📊 СТАТИСТИКА
            Text(
              "Всего активностей: ${(student['activities'] ?? []).length}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
