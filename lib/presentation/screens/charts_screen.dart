import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../services/chart_service.dart';
import '../bloc/student_cubit.dart';
import '../bloc/tracking_cubit.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final students = context.watch<StudentCubit>().state;
    final tracking = context.watch<TrackingCubit>();

    if (students.isEmpty) {
      return const Scaffold(body: Center(child: Text("No students")));
    }

    final data = ChartService.build(students[selected]);

    return Scaffold(
      appBar: AppBar(title: const Text("Charts")),

      body: Column(
        children: [
          DropdownButton(
            value: selected,
            items: List.generate(
              students.length,
              (i) => DropdownMenuItem(
                value: i,
                child: Text(students[i]['name']),
              ),
            ),
            onChanged: (v) => setState(() => selected = v as int),
          ),

          ElevatedButton(
            onPressed: tracking.state
                ? () => tracking.finish(selected)
                : () => tracking.startTrack(),
            child: Text(tracking.state ? "Finish" : "Start"),
          ),

          Expanded(
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(spots: data),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
