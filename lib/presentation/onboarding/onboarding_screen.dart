import 'package:flutter/material.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      // color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Color(0xFFD8E2E4),
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(0xFFD8E2E4),
                ),
          ),
        ],
      ),
    );
  }
}
