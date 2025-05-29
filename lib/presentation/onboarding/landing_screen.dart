import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quizdioms/presentation/onboarding/onboarding_screen.dart';
import 'package:quizdioms/services/onboarding_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:go_router/go_router.dart';

final onboardingSlides = [
  OnboardingSlide(
    title: "Welcome to Quizdioms",
    subtitle:
        "Discover a smarter way to boost your English with engaging quizzes, visual learning, and progress tracking—all designed to make learning enjoyable and effective.",
    image: "assets/illustrations/quizzes.png",
  ),
  OnboardingSlide(
    title: "Idioms",
    subtitle:
        "Explore powerful idiomatic expressions through beautifully animated flip cards. Understand their meanings and real-life usage with clarity and confidence.",
    image: "assets/illustrations/idioms.png",
  ),
  OnboardingSlide(
    title: "Phrases",
    subtitle:
        "Master everyday English phrases to improve your fluency. Practice how native speakers communicate in real conversations with relatable examples.",
    image: "assets/illustrations/phrases.png",
  ),
  OnboardingSlide(
    title: "Ready to Begin?",
    subtitle:
        "Take the first step on your language learning journey. Whether it's 5 minutes or 50, Quizdioms is here to help you grow one day at a time.",
    image: "assets/illustrations/go.png",
  ),
];

class LandingScreen extends HookWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = usePageController();
    final isLastPage = useState(false);

    final isWeb = MediaQuery.of(context).size.width >= 640;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF316E79),
            Color(0xFF88A6AA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 640),
            child: Stack(
              children: [
                PageView.builder(
                  controller: controller,
                  itemCount: onboardingSlides.length,
                  onPageChanged: (index) =>
                      isLastPage.value = index == onboardingSlides.length - 1,
                  itemBuilder: (_, index) => onboardingSlides[index],
                ),
                Positioned(
                  right: isWeb ? 22 : 16,
                  top: 48,
                  child: TextButton(
                    onPressed: () async {
                      await OnboardingService().setCompleted();
                      if (!context.mounted) return;
                      context.go('/signin');
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFD8E2E4),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFD8E2E4)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      SmoothPageIndicator(
                        controller: controller,
                        count: onboardingSlides.length,
                        effect: WormEffect(
                          dotHeight: 12,
                          dotWidth: 12,
                          activeDotColor: Color(0xFFD8E2E4),
                          dotColor: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            minimumSize: const Size(double.infinity, 56),
                            textStyle: TextStyle(fontSize: 16),
                          ),
                          onPressed: () async {
                            if (isLastPage.value) {
                              await OnboardingService().setCompleted();
                              // await UserRemoteDatasource()
                              // .markOnboardingComplete(); // Firestore
                              if (!context.mounted) return; // ✅ safe check
                              context.go('/signin');
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            }
                          },
                          child:
                              Text(isLastPage.value ? "Get Started" : "Next"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
