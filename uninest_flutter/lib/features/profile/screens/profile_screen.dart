import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../auth/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Profile header
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user?.userMetadata?['full_name'] ?? 'Guest User',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? 'guest@uninest.com',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    // TODO: Navigate to edit profile
                  },
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Stats
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(label: 'Posts', value: '12'),
                _StatItem(label: 'Followers', value: '234'),
                _StatItem(label: 'Following', value: '156'),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Menu items
        _MenuItem(
          icon: Icons.settings,
          title: 'Settings',
          onTap: () => context.push(RouteNames.settings),
        ),
        _MenuItem(
          icon: Icons.chat,
          title: 'Messages',
          onTap: () => context.push(RouteNames.chat),
        ),
        _MenuItem(
          icon: Icons.favorite,
          title: 'Saved Items',
          onTap: () {},
        ),
        _MenuItem(
          icon: Icons.admin_panel_settings,
          title: 'Admin Panel',
          onTap: () => context.push(RouteNames.admin),
        ),
        _MenuItem(
          icon: Icons.support_agent,
          title: 'Support',
          onTap: () => context.push(RouteNames.support),
        ),
        _MenuItem(
          icon: Icons.favorite,
          title: 'Donate',
          onTap: () => context.push(RouteNames.donate),
        ),
        
        const SizedBox(height: 16),
        
        // Logout button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await ref.read(authControllerProvider).signOut();
              if (context.mounted) {
                context.go(RouteNames.login);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
