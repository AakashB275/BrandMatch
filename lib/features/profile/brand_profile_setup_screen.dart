import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BrandProfileSetupScreen extends StatelessWidget {
  const BrandProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Brand Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  TextField(decoration: InputDecoration(labelText: 'Company name', prefixIcon: Icon(Icons.apartment_outlined))),
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(labelText: 'Description', prefixIcon: Icon(Icons.description_outlined)),
                    maxLines: 3,
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
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Location (Google Places)',
                      prefixIcon: Icon(Icons.place_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Tags', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: -8,
                    children: const [
                      Chip(label: Text('streetwear')),
                      Chip(label: Text('editorial')),
                      Chip(label: Text('commercial')),
                      Chip(label: Text('beauty')),
                    ],
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
                      labelText: 'Campaign type',
                      prefixIcon: Icon(Icons.campaign_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Budget range (e.g., \$1000-\$5000)',
                      prefixIcon: Icon(Icons.attach_money_outlined),
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
                  Text('Brand logo', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.image_outlined),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.upload_outlined), label: const Text('Upload logo')),
                    ],
                  ),
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
