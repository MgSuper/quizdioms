import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class OnboardingSlide extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const OnboardingSlide({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final isWeb = kIsWeb;
    final maxWidth = 640.0;
    final imageHeight = isWeb ? 300.0 : 200.0;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image, height: imageHeight),
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: const Color(0xFFD8E2E4),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: const Color(0xFFD8E2E4),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
