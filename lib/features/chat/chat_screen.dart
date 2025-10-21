import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String matchId;
  const ChatScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat #$matchId'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              reverse: true,
              itemCount: 16,
              itemBuilder: (_, i) {
                final isMe = i % 2 == 0;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? cs.primaryContainer : cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      isMe ? 'Hey there!' : 'Hello! This is a placeholder message.',
                      style: TextStyle(color: isMe ? cs.onPrimaryContainer : cs.onSurface),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline)),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Message... (links blocked)',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.send), label: const Text('Send')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
