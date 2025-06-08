import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizdioms/presentation/providers/theme_mode_provider.dart';
import 'package:quizdioms/presentation/routes/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
        GlobalKey<ScaffoldMessengerState>();
    final themeModeAsync = ref.watch(themeModeProvider);

    if (themeModeAsync is AsyncLoading) {
      return const CircularProgressIndicator(); // or splash screen
    }

    return MaterialApp.router(
      routerConfig: ref.watch(goRouterProvider),
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Quizdioms',
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          headlineLarge: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFD8E2E4),
          ),
          bodyLarge: const TextStyle(
            fontSize: 18,
            color: Color(0xFFD8E2E4),
          ),
          bodyMedium: const TextStyle(
            fontSize: 16,
            color: Color(0xFFD8E2E4),
          ),
          bodySmall: const TextStyle(
            fontSize: 14,
            color: Color(0xFFD8E2E4),
          ),
          labelSmall: const TextStyle(
            fontSize: 12,
            color: Color(0xFFD8E2E4),
          ),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Color(0xFFD8E2E4),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(
            color: Color(0xFFD8E2E4),
          ),
        ),
        cardTheme: CardTheme(
          color: Color(0xFFD8E2E4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        listTileTheme: ListTileThemeData(
          style: ListTileStyle.drawer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          titleTextStyle: TextStyle(
              color: Color(0xFFD8E2E4),
              fontWeight: FontWeight.w600,
              fontSize: 16),
          subtitleTextStyle: TextStyle(
            color: Color(0xFFD8E2E4),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Color(0xFFD8E2E4)),
          floatingLabelStyle: TextStyle(color: Color(0xFFD8E2E4)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          border: OutlineInputBorder(), // Default border
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: themeModeAsync.value ?? ThemeMode.system,
    );
  }
}
