import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quizdioms/presentation/providers/auth_provider.dart';

class UserAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  const UserAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return kIsWeb
        ? Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: RAppBar(title: title, ref: ref),
            ),
          )
        : RAppBar(title: title, ref: ref);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class RAppBar extends StatelessWidget {
  const RAppBar({
    super.key,
    required this.title,
    required this.ref,
  });

  final String title;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width >= 640;
    final padding = isWeb
        ? const EdgeInsets.symmetric(horizontal: 24)
        : const EdgeInsets.symmetric(horizontal: 4);
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: padding,
        child: Text(
          title,
          style: TextStyle(
            color: Color(0xFFD8E2E4),
          ),
        ),
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: padding,
          child: IconButton(
            icon: const Icon(
              Icons.logout,
              color: Color(0xFFD8E2E4),
            ),
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).signOut();
            },
          ),
        ),
      ],
    );
  }
}
