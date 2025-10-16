import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../widgets/feature_card.dart';
import '../widgets/stat_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
          ).createShader(bounds),
          child: Text(
            AppConstants.appName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.go(RouteNames.search),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Show notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.school, color: Colors.white, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome to ${AppConstants.appName}!',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${AppConstants.appTagline} ✨',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Stats Section
            Text(
              'Join ${AppConstants.studentsCount}+ Students',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    icon: Icons.people,
                    value: '${AppConstants.studentsCount ~/ 1000}K+',
                    label: 'Students',
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    icon: Icons.store,
                    value: '${AppConstants.vendorsCount}+',
                    label: 'Vendors',
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    icon: Icons.library_books,
                    value: '${AppConstants.librariesCount}+',
                    label: 'Services',
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Features Section
            Text(
              'Explore Features',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                FeatureCard(
                  icon: Icons.people,
                  title: 'Social Network',
                  description: 'Connect with peers',
                  color: Colors.blue,
                  onTap: () => context.go(RouteNames.social),
                ),
                FeatureCard(
                  icon: Icons.shopping_bag,
                  title: 'Marketplace',
                  description: 'Buy & sell items',
                  color: Colors.green,
                  onTap: () => context.go(RouteNames.marketplace),
                ),
                FeatureCard(
                  icon: Icons.book,
                  title: 'Study Hub',
                  description: 'Share notes & resources',
                  color: Colors.purple,
                  onTap: () => context.go(RouteNames.notes),
                ),
                FeatureCard(
                  icon: Icons.work,
                  title: 'Opportunities',
                  description: 'Find internships & jobs',
                  color: Colors.orange,
                  onTap: () => context.go(RouteNames.workspace),
                ),
                FeatureCard(
                  icon: Icons.bed,
                  title: 'Hostels',
                  description: 'Find accommodation',
                  color: Colors.teal,
                  onTap: () => context.go(RouteNames.hostels),
                ),
                FeatureCard(
                  icon: Icons.chat,
                  title: 'Chat',
                  description: 'Message friends',
                  color: Colors.indigo,
                  onTap: () => context.go(RouteNames.chat),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Quick Actions
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Text(
                    'Quick Actions',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => context.go(RouteNames.feed),
                          icon: const Icon(Icons.feed),
                          label: const Text('View Feed'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => context.go(RouteNames.search),
                          icon: const Icon(Icons.search),
                          label: const Text('Search'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
