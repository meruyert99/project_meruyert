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
    final data = classes[selectedClassIndex]['students'];
    return data ?? [];
  }

  /// 📊 график по часам
  List<FlSpot> buildChart(List activities) {
    Map<int, double> map = {};

    for (var item in activities) {
      final dt = DateTime.tryParse(item.toString());
      if (dt == null) continue;

      final hour = dt.hour;
      map[hour] = (map[hour] ?? 0) + 1;
    }

    return List.generate(
      24,
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
    final studentsList = classItem['students'] ?? [];

    if (studentsList.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Нет учеников")),
      );
    }

    final student = studentsList[selectedStudentIndex];
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
            /// 📚 CLASS SELECTOR
            DropdownButtonFormField<int>(
              value: selectedClassIndex,
              decoration: const InputDecoration(labelText: "Класс"),
              items: List.generate(
                classes.length,
                (i) => DropdownMenuItem(
                  value: i,
                  child: Text(classes[i]['name'] ?? 'Class $i'),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  selectedClassIndex = val ?? 0;
                  selectedStudentIndex = 0;
                });
              },
            ),

            const SizedBox(height: 12),

            /// 👤 STUDENT SELECTOR
            DropdownButtonFormField<int>(
              value: selectedStudentIndex,
              decoration: const InputDecoration(labelText: "Ученик"),
              items: List.generate(
                studentsList.length,
                (i) => DropdownMenuItem(
                  value: i,
                  child: Text(studentsList[i]['name'] ?? 'Student $i'),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  selectedStudentIndex = val ?? 0;
                });
              },
            ),

            const SizedBox(height: 20),

            /// 📈 CHART
            Expanded(
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: data.isEmpty
                      ? const Center(
                          child: Text("Нет активности"),
                        )
                      : LineChart(
                          LineChartData(
                            minY: 0,
                            maxY: 10,

                            gridData: FlGridData(show: true),

                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 3,
                                  getTitlesWidget: (value, _) {
                                    return Text('${value.toInt()}h');
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),

                            borderData: FlBorderData(show: true),

                            lineBarsData: [
                              LineChartBarData(
                                spots: data,
                                isCurved: true,
                                barWidth: 3,
                                color: Colors.blue,
                                dotData: FlDotData(show: false),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// 📌 STATS
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