import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import '../../../core/constants/app_constants.dart';
import '../widgets/feature_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/testimonial_card.dart';
import '../widgets/timeline_item.dart';
import '../widgets/donation_modal.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isDonationModalOpen = false;

  @override
  void initState() {
    super.initState();
    // Show donation modal after 2 seconds (similar to web version)
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isDonationModalOpen = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch() {
    if (_searchController.text.trim().isNotEmpty) {
      context.go('/search?q=${Uri.encodeComponent(_searchController.text.trim())}');
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome and Search Section (matching web)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          const TextSpan(text: 'Welcome to '),
                          TextSpan(
                            text: 'UniNest!',
                            style: TextStyle(
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                                ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your all-in-one digital campus hub ✨',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: theme.dividerColor.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search for notes, products, or people...',
                          prefixIcon: const Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                        onSubmitted: (_) => _handleSearch(),
                      ),
                    ),
                  ],
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
            
            // Feature Cards (4 cards like web)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildFeatureCard(
                  context,
                  icon: Icons.people,
                  title: 'Social',
                  description: 'See what\'s trending',
                  color: Colors.blue,
                  route: RouteNames.social,
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.shopping_bag,
                  title: 'Marketplace',
                  description: 'Featured items',
                  color: Colors.green,
                  route: RouteNames.marketplace,
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.book,
                  title: 'Study Hub',
                  description: 'Upload & Share',
                  color: Colors.purple,
                  route: RouteNames.notes,
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.dashboard,
                  title: 'Workspace',
                  description: 'Compete & Grow',
                  color: Colors.orange,
                  route: RouteNames.workspace,
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Testimonials Section
            const SizedBox(height: 48),
            Center(
              child: Text(
                'Loved by Students Everywhere',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            FlutterCarousel(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: true,
                viewportFraction: 0.9,
              ),
              items: [
                TestimonialCard(
                  quote: 'UniNest completely changed how I find study materials. The note sharing is a lifesaver!',
                  name: 'Fatima Khan',
                  school: 'Jamia Millia Islamia',
                  avatarUrl: 'https://picsum.photos/seed/testimonial1/100',
                ),
                TestimonialCard(
                  quote: 'The marketplace is brilliant. I sold all my old textbooks in a week!',
                  name: 'John Mathew',
                  school: 'St. Stephen\'s College',
                  avatarUrl: 'https://picsum.photos/seed/testimonial2/100',
                ),
                TestimonialCard(
                  quote: 'As a fresher, UniNest helped me feel connected to the campus community instantly.',
                  name: 'Jaspreet Kaur',
                  school: 'Guru Nanak Dev University',
                  avatarUrl: 'https://picsum.photos/seed/testimonial3/100',
                ),
              ],
            ),
            
            // Timeline Section
            const SizedBox(height: 48),
            Center(
              child: Text(
                'Our Journey So Far',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                TimelineItem(
                  year: '2024',
                  title: 'The Vision',
                  description: 'Founded with a mission to simplify student life.',
                  icon: Icons.auto_awesome,
                  isFirst: true,
                ),
                TimelineItem(
                  year: '2024 Q2',
                  title: 'First 1,000 Users',
                  description: 'Our community begins to take shape.',
                  icon: Icons.people,
                ),
                TimelineItem(
                  year: '2025 Q1',
                  title: '10,000 Strong',
                  description: 'Crossed 10k students & 200 vendors.',
                  icon: Icons.rocket_launch,
                ),
                TimelineItem(
                  year: 'Future',
                  title: 'Global Expansion',
                  description: 'Connecting 100,000+ learners worldwide.',
                  icon: Icons.public,
                  isLast: true,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
      // Donation Modal
      if (_isDonationModalOpen)
        DonationModal(
          isOpen: _isDonationModalOpen,
          onClose: () {
            setState(() {
              _isDonationModalOpen = false;
            });
          },
        ),
      ],
    ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
