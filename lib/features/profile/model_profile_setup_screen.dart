import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModelProfileSetupScreen extends StatelessWidget {
  const ModelProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Model Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  TextField(decoration: InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person_outline))),
                  SizedBox(height: 12),
                  TextField(decoration: InputDecoration(labelText: 'Age', prefixIcon: Icon(Icons.cake_outlined)), keyboardType: TextInputType.number),
                  SizedBox(height: 12),
                  TextField(decoration: InputDecoration(labelText: 'Gender (optional)', prefixIcon: Icon(Icons.wc_outlined))),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tags', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: -8,
                    children: const [
                      Chip(label: Text('streetwear')),
                      Chip(label: Text('editorial')),
                      Chip(label: Text('commercial')),
                      Chip(label: Text('fitness')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Max distance (km)',
                      prefixIcon: Icon(Icons.place_outlined),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    items: const [
                      DropdownMenuItem(value: 'Paid', child: Text('Paid')),
                      DropdownMenuItem(value: 'Collab', child: Text('Collab')),
                      DropdownMenuItem(value: 'Barter', child: Text('Barter')),
                    ],
                    onChanged: (_) {},
                    decoration: const InputDecoration(
                      labelText: 'Collaboration type',
                      prefixIcon: Icon(Icons.handshake_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Portfolio (4–10 images)', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
                    itemBuilder: (_, i) => Container(
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.image_outlined),
                    ),
                    itemCount: 6,
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.upload_outlined), label: const Text('Upload images')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () => context.go('/home'),
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Save & Continue'),
          ),
        ],
      ),
    );
  }
}
