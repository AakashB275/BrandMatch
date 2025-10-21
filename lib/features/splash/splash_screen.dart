import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:brand_model_matching/ui/widgets/gradient_header.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      // TODO: Check auth session & verification status
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      if (false) {
        context.go('/home');
      } else {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        children: [
          const GradientHeader(title: 'Brandmatch', subtitle: 'Connect brands and models'),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite, size: 64, color: cs.primary),
                  const SizedBox(height: 16),
                  const SizedBox(height: 8),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
