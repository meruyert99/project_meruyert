import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Column(
        children: [
          ListTile(
            title: Text("Students"),
            onTap: () => context.push('/students'),
          ),
          ListTile(
            title: Text("Search"),
            onTap: () => context.push('/search'),
          ),
          ListTile(
            title: Text("Charts"),
            onTap: () => context.push('/charts'),
          ),
        ],
      ),
    );
  }
}