import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final box = Hive.box('studentsBox');
  String query = "";

  @override
  Widget build(BuildContext context) {
    final students = box.values
        .where((s) => s['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: Column(
        children: [
          TextField(
            onChanged: (val) => setState(() => query = val),
            decoration: InputDecoration(hintText: "Search student"),
          ),
          Expanded(
            child: ListView(
              children: students
                  .map((s) => ListTile(title: Text(s['name'])))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}