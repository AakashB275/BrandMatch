import 'package:flutter/material.dart';

class DiscoveryScreen extends StatelessWidget {
  const DiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.tune))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              children: const [
                Padding(padding: EdgeInsets.only(right: 8), child: FilterChip(label: Text('Nearby'), selected: true, onSelected: null)),
                Padding(padding: EdgeInsets.only(right: 8), child: FilterChip(label: Text('Streetwear'), onSelected: null)),
                Padding(padding: EdgeInsets.only(right: 8), child: FilterChip(label: Text('Editorial'), onSelected: null)),
                Padding(padding: EdgeInsets.only(right: 8), child: FilterChip(label: Text('Commercial'), onSelected: null)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text('Swipe stack placeholder'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _circleBtn(context, Icons.close_rounded, cs.error),
                _circleBtn(context, Icons.favorite, cs.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _circleBtn(BuildContext context, IconData icon, Color color) {
  return Container(
    width: 64,
    height: 64,
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      shape: BoxShape.circle,
    ),
    child: IconButton(
      icon: Icon(icon, color: color),
      onPressed: () {},
    ),
  );
}
