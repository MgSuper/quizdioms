import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizdioms/presentation/admin/presentation/widgets/admin_dashboard_card.dart';
import 'package:quizdioms/presentation/providers/auth_provider.dart';
import 'package:quizdioms/presentation/routes/app_router.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<_DashboardItem> items = [
      _DashboardItem(
        title: 'Manage Quizzes',
        icon: Icons.quiz,
        route: '/admin/manage-quizzes',
      ),
      _DashboardItem(
        title: 'Manage Idioms',
        icon: Icons.language,
        route: '/admin/manage-idioms',
      ),
      _DashboardItem(
        title: 'Manage Quotes',
        icon: Icons.format_quote,
        route: '/admin/manage-quotes',
      ),
      _DashboardItem(
        title: 'User Performance',
        icon: Icons.bar_chart,
        route: '/admin/user-performance',
      ),
    ];

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Admin Dashboard',
            style: TextStyle(),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: () async {
                await ref.read(authControllerProvider.notifier).signOut();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two cards per row
              crossAxisSpacing: 12,
              mainAxisSpacing: 8,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return AdminDashboardCard(
                title: item.title,
                icon: item.icon,
                onTap: () {
                  print('item.route ${item.route}');
                  ref.read(goRouterProvider).push(item.route);
                  // Navigator.pushNamed(context, item.route);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DashboardItem {
  final String title;
  final IconData icon;
  final String route;

  _DashboardItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}
