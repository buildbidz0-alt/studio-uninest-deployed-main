import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/helpers.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Total Users',
                  value: '10,234',
                  icon: Icons.people,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: 'Active Today',
                  value: '1,543',
                  icon: Icons.trending_up,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Total Posts',
                  value: '5,678',
                  icon: Icons.post_add,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: 'Revenue',
                  value: '₹45.2K',
                  icon: Icons.attach_money,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Management Sections
          Text(
            'Management',
            style: theme.textTheme.headlineMedium,
          ),
          
          const SizedBox(height: 12),
          
          _AdminMenuItem(
            icon: Icons.people,
            title: 'Manage Users',
            subtitle: 'View and manage user accounts',
            onTap: () {},
          ),
          _AdminMenuItem(
            icon: Icons.post_add,
            title: 'Manage Posts',
            subtitle: 'Moderate posts and content',
            onTap: () {},
          ),
          _AdminMenuItem(
            icon: Icons.shopping_bag,
            title: 'Manage Marketplace',
            subtitle: 'Review marketplace listings',
            onTap: () {},
          ),
          _AdminMenuItem(
            icon: Icons.work,
            title: 'Manage Competitions',
            subtitle: 'Add and edit competitions',
            onTap: () {},
          ),
          _AdminMenuItem(
            icon: Icons.business,
            title: 'Manage Internships',
            subtitle: 'Add and edit internship listings',
            onTap: () {},
          ),
          _AdminMenuItem(
            icon: Icons.payment,
            title: 'Payments',
            subtitle: 'View payment transactions',
            onTap: () {},
          ),
          _AdminMenuItem(
            icon: Icons.support_agent,
            title: 'Support Tickets',
            subtitle: 'Manage user support requests',
            onTap: () {},
          ),
          _AdminMenuItem(
            icon: Icons.analytics,
            title: 'Analytics',
            subtitle: 'View detailed analytics',
            onTap: () {},
          ),
          _AdminMenuItem(
            icon: Icons.settings,
            title: 'System Settings',
            subtitle: 'Configure system settings',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AdminMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, size: 28),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
