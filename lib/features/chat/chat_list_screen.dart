import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: 12,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) => Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('${i + 1}')),
            title: Text('Match #${i + 1}'),
            subtitle: const Text('Last message preview goes here...'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('2m', style: TextStyle(fontSize: 12)),
              ],
            ),
            onTap: () => context.go('/chat/${i + 1}'),
          ),
        ),
      ),
    );
  }
}
