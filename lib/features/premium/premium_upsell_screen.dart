import 'package:flutter/material.dart';

class PremiumUpsellScreen extends StatelessWidget {
  const PremiumUpsellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Go Premium')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Premium benefits', style: TextStyle(fontWeight: FontWeight.w700)),
                  SizedBox(height: 12),
                  _BenefitRow(text: 'See who liked you'),
                  _BenefitRow(text: 'Extended match timer (48h)'),
                  _BenefitRow(text: 'Extended visibility when inactive'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.workspace_premium_outlined, color: cs.primary),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Premium — One simple plan'),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: const Text('Subscribe'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  final String text;
  const _BenefitRow({required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: cs.primary, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
