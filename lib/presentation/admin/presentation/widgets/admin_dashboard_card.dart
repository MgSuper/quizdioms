import 'package:flutter/material.dart';

class AdminDashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const AdminDashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Color(0xFF316E79)
                  // color: Color(0xFFD8E2E4),
                  ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Color(0xFF316E79),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
