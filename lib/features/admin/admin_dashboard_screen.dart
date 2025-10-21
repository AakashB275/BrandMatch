import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Approve/Reject verifications (placeholder)'),
          SizedBox(height: 8),
          Text('Manage reports (placeholder)'),
          SizedBox(height: 8),
          Text('Edit pricing tiers (placeholder)'),
          SizedBox(height: 8),
          Text('Stats: total users, matches, revenue (placeholder)'),
        ],
      ),
    );
  }
}
