import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';

import 'package:template/data/lesson_controller.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  final box = Hive.box('studentsBox');
  final lesson = LessonController.instance;

  int selectedStudentIndex = 0;

  // 👨‍🎓 STUDENTS (SAFE)
  List<Map> get students {
    if (box.isEmpty) return [];

    final classItem = Map<String, dynamic>.from(box.getAt(0));

    return List<Map>.from(classItem['students'] ?? []);
  }

  // ▶ START
  void startLesson() {
    setState(() {
      lesson.start();
    });
  }

  // ⛔ STOP
  void stopLesson() {
    setState(() {
      lesson.stop();
    });
  }

  // 🔁 RESET
  void resetLesson() {
    setState(() {
      lesson.reset();
    });
  }

  // 📊 ANALYTICS (MINUTES FROM START)
  List<FlSpot> buildChart(List activities) {
    const int lessonDuration = 30;

    final Map<int, double> minuteMap = {};

    final start = lesson.lessonStartTime;
    final end = lesson.lessonEndTime ?? DateTime.now();

    if (start == null) {
      return List.generate(
        lessonDuration,
        (i) => FlSpot(i.toDouble(), 0),
      );
    }

    for (var item in activities) {
      final dt = DateTime.tryParse(item.toString());
      if (dt == null) continue;

      if (dt.isBefore(start) || dt.isAfter(end)) continue;

      final minute = dt.difference(start).inMinutes;

      if (minute >= 0 && minute < lessonDuration) {
        minuteMap[minute] = (minuteMap[minute] ?? 0) + 1;
      }
    }

    return List.generate(
      lessonDuration,
      (min) => FlSpot(
        min.toDouble(),
        minuteMap[min] ?? 0,
      ),
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

    final chartData = buildChart(activities);

    return Scaffold(
      appBar: AppBar(
        title: const Text("📊 Lesson Tracker"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 👨‍🎓 SELECT STUDENT
            DropdownButtonFormField<int>(
              value: selectedStudentIndex,
              decoration: const InputDecoration(
                labelText: "Выберите ученика",
                border: OutlineInputBorder(),
              ),
              items: List.generate(
                students.length,
                (i) => DropdownMenuItem(
                  value: i,
                  child: Text(students[i]['name'] ?? 'No name'),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  selectedStudentIndex = val ?? 0;
                });
              },
            ),

            const SizedBox(height: 10),

            // 🎮 CONTROLS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: lesson.isRunning ? null : startLesson,
                  child: const Text("Start"),
                ),
                ElevatedButton(
                  onPressed: lesson.isRunning ? stopLesson : null,
                  child: const Text("Stop"),
                ),
                ElevatedButton(
                  onPressed: resetLesson,
                  child: const Text("Reset"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 📈 CHART
            Expanded(
              child: LineChart(
                LineChartData(
                  minY: 0,
                  gridData: const FlGridData(show: true),

                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5,
                        getTitlesWidget: (value, meta) {
                          return Text("${value.toInt()}m");
                        },
                      ),
                    ),
                  ),

                  lineBarsData: [
                    LineChartBarData(
                      spots: chartData,
                      isCurved: true,
                      curveSmoothness: 0.4,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              lesson.lessonStartTime == null
                  ? "Lesson not started"
                  : lesson.lessonEndTime == null
                      ? "Lesson running..."
                      : "Lesson finished",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

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