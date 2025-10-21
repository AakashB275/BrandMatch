import 'package:flutter/material.dart';
import '../features/discovery/discovery_screen.dart';
import '../features/matches/matches_screen.dart';
import '../features/chat/chat_list_screen.dart';
import '../features/settings/settings_screen.dart';

class BottomNavScaffold extends StatefulWidget {
  const BottomNavScaffold({super.key});

  @override
  State<BottomNavScaffold> createState() => _BottomNavScaffoldState();
}

class _BottomNavScaffoldState extends State<BottomNavScaffold> {
  int _index = 0;
  final _pages = const [
    DiscoveryScreen(),
    MatchesScreen(),
    ChatListScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.explore_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.favorite_outline), label: 'Matches'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
