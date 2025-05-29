import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserBottomNavScaffold extends StatelessWidget {
  final Widget child;
  const UserBottomNavScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int currentIndex = 0;
    if (location.contains('/user/idioms')) {
      currentIndex = 1;
    } else if (location.contains('/user/phrases')) {
      currentIndex = 2;
    } else if (location.contains('/user/performance')) {
      currentIndex = 3;
    } else if (location.contains('/user/profile')) {
      currentIndex = 4;
    }

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
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 640)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: NavigationRail(
                    backgroundColor: Colors.transparent,
                    selectedIconTheme:
                        const IconThemeData(size: 28, color: Color(0xFF88D4B8)),
                    unselectedIconTheme:
                        const IconThemeData(size: 24, color: Color(0xFFD8E2E4)),
                    selectedLabelTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF88D4B8), // Light minty green
                    ),
                    unselectedLabelTextStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFD8E2E4),
                    ),
                    labelType: NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(
                          icon: Icon(Icons.quiz), label: Text('Quizz')),
                      NavigationRailDestination(
                          icon: Icon(Icons.book), label: Text('Idioms')),
                      NavigationRailDestination(
                          icon: Icon(Icons.chat), label: Text('Phrases')),
                      NavigationRailDestination(
                          icon: Icon(Icons.bar_chart),
                          label: Text('Performance')),
                      NavigationRailDestination(
                          icon: Icon(Icons.person), label: Text('Profile')),
                    ],
                    selectedIndex: currentIndex,
                    onDestinationSelected: (index) {
                      switch (index) {
                        case 0:
                          context.go('/user/quizzes');
                          break;
                        case 1:
                          context.go('/user/idioms');
                          break;
                        case 2:
                          context.go('/user/phrases');
                          break;
                        case 3:
                          context.go('/user/performance');
                          break;
                        case 4:
                          context.go('/user/profile');
                          break;
                      }
                    }),
              ),
            Expanded(child: child)
          ],
        ),
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedLabelStyle: TextStyle(
                  color: Color(0xFFD8E2E4),
                ),
                unselectedItemColor: Color(0xFF316E79),
                selectedItemColor: Color(0xFFD8E2E4),
                currentIndex: currentIndex,
                onTap: (index) {
                  switch (index) {
                    case 0:
                      context.go('/user/quizzes');
                      break;
                    case 1:
                      context.go('/user/idioms');
                      break;
                    case 2:
                      context.go('/user/phrases');
                      break;
                    case 3:
                      context.go('/user/performance');
                      break;
                    case 4:
                      context.go('/user/profile');
                      break;
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.quiz), label: 'Quizz'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.book), label: 'Idioms'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat), label: 'Phrases'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bar_chart), label: 'Performance'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Profile'),
                ],
                type: BottomNavigationBarType.fixed,
              )
            : null,
      ),
    );
  }
}
