import 'package:flutter/material.dart';

/// Placeholder. Diisi bertahap: login/logout (Hari 3), export CSV (Hari 9).
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.brightness_6_outlined),
            title: Text('Tema'),
            subtitle: Text('Mengikuti pengaturan sistem'),
          ),
          ListTile(
            leading: Icon(Icons.file_download_outlined),
            title: Text('Export CSV'),
            subtitle: Text('Segera hadir (Hari 9)'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Keluar'),
            subtitle: Text('Segera hadir (Hari 3)'),
          ),
        ],
      ),
    );
  }
}
