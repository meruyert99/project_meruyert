import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),

          // 🌙 DARK MODE
          SwitchListTile(
            title: const Text("Dark Mode"),
            subtitle: const Text("Switch theme"),
            value: theme.isDark,
            onChanged: (_) => theme.toggleTheme(),
            secondary: const Icon(Icons.dark_mode),
          ),

          const Divider(),

          // 🔔 NOTIFICATIONS
          SwitchListTile(
            title: const Text("Notifications"),
            subtitle: const Text("Enable alerts"),
            value: true,
            onChanged: (value) {
              // TODO: подключить логику уведомлений
            },
            secondary: const Icon(Icons.notifications),
          ),

          const Divider(),

          // 🌐 LANGUAGE
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            subtitle: const Text("English / Russian"),
            onTap: () {
              // TODO: открыть выбор языка
            },
          ),

          const Divider(),

          // ℹ️ ABOUT
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About app"),
            subtitle: const Text("Information about this application"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Student Tracker",
                applicationVersion: "1.0.0",
                applicationIcon: const Icon(Icons.school, size: 40),
                applicationLegalese: "Made by Meruyert",
                children: const [
                  SizedBox(height: 10),
                  Text(
                    "Student Tracker helps teachers monitor student activity during lessons, "
                    "track engagement, and analyze classroom performance in real time.",
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}