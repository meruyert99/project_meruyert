import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Column(
        children: [
          ListTile(
            title: const Text("Students"),
            onTap: () => context.push('/students'),
          ),
          ListTile(
            title: const Text("Charts"),
            onTap: () => context.push('/charts'),
          ),
        ],
      ),
    );
  }
}
