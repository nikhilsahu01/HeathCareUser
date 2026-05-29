import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _darkModeEnabled = prefs.getBool('darkModeEnabled') ?? false;
    });
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Settings"),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Preferences",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SwitchListTile(
              title: const Text("Push Notifications"),
              subtitle: const Text("Receive updates and reminders"),
              value: _notificationsEnabled,
              activeColor: const Color(0xFF0066FF),
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                _saveSetting('notificationsEnabled', value);
              },
            ),
            const Divider(),
            SwitchListTile(
              title: const Text("Dark Mode"),
              subtitle: const Text("Enable dark theme across the app"),
              value: _darkModeEnabled,
              activeColor: const Color(0xFF0066FF),
              onChanged: (bool value) {
                setState(() {
                  _darkModeEnabled = value;
                });
                _saveSetting('darkModeEnabled', value);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Theme change will apply on next restart"))
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text("Language"),
              subtitle: const Text("English"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Future implementation
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
