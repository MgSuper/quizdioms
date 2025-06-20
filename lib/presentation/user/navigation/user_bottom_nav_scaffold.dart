import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserBottomNavScaffold extends StatelessWidget {
  final Widget child;
  const UserBottomNavScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    int currentIndex = 0;
    if (location.contains('/user/learning')) {
      currentIndex = 1;
    } else if (location.contains('/user/performance')) {
      currentIndex = 2;
    } else if (location.contains('/user/profile')) {
      currentIndex = 3;
    }

    final scaffold = Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: NavigationRail(
                backgroundColor: Colors.transparent,
                selectedIconTheme: IconThemeData(
                    size: 28, color: Theme.of(context).colorScheme.primary),
                unselectedIconTheme: IconThemeData(
                    size: 24, color: Theme.of(context).colorScheme.onSurface),
                selectedLabelTextStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
                unselectedLabelTextStyle: Theme.of(context).textTheme.bodySmall,
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                      icon: Icon(Icons.quiz), label: Text('Quizz')),
                  NavigationRailDestination(
                      icon: Icon(Icons.book), label: Text('Learning')),
                  NavigationRailDestination(
                      icon: Icon(Icons.bar_chart), label: Text('Notification')),
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
                      context.go('/user/learning');
                      break;
                    case 2:
                      context.go('/user/performance');
                      break;
                    case 3:
                      context.go('/user/profile');
                      break;
                  }
                },
              ),
            ),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedLabelStyle: TextStyle(
                color: Color(0xFFD8E2E4),
                fontSize: 16,
              ),
              unselectedLabelStyle: TextStyle(
                color: Color(0xFFD8E2E4),
                fontSize: 14,
              ),
              unselectedItemColor: Color(0xFFD8E2E4),
              selectedItemColor: Color(0xFF316E79),
              currentIndex: currentIndex,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go('/user/quizzes');
                    break;
                  case 1:
                    context.go('/user/learning');
                    break;
                  case 2:
                    context.go('/user/performance');
                    break;
                  case 3:
                    context.go('/user/profile');
                    break;
                }
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quizz'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book), label: 'Learning'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_on), label: 'Notification'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
              type: BottomNavigationBarType.fixed,
            )
          : null,
    );

    return isLightTheme
        ? Container(
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
            child: scaffold,
          )
        : scaffold;
  }
}
