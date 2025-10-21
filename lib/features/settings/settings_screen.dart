import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              leading: CircleAvatar(backgroundColor: cs.primary, child: const Icon(Icons.person, color: Colors.white)),
              title: const Text('Your Name'),
              subtitle: const Text('Model / Brand'),
              trailing: const Icon(Icons.edit_outlined),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.verified_user_outlined),
              title: const Text('Verification Status'),
              subtitle: const Text('Pending / Verified / Rejected'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: const [
                ListTile(leading: Icon(Icons.tune_outlined), title: Text('Preferences'), trailing: Icon(Icons.chevron_right)),
                Divider(height: 1),
                ListTile(leading: Icon(Icons.shield_outlined), title: Text('Privacy & Safety'), trailing: Icon(Icons.chevron_right)),
                Divider(height: 1),
                ListTile(leading: Icon(Icons.notifications_outlined), title: Text('Notifications'), trailing: Icon(Icons.chevron_right)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
