import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../config/theme.dart';
import '../../../core/constants/app_constants.dart';
import '../widgets/feature_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/testimonial_card.dart';
import '../widgets/timeline_item.dart';

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
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Navigate to search
              context.push('/search');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome and Search Section (matching web)
            Text(
              'Welcome to ',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
              ).createShader(bounds),
              child: Text(
                'UniNest!',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your all-in-one digital campus hub ✨',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Search Bar (matching web)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search for notes, products, or people...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    context.push('/search?q=${Uri.encodeComponent(value.trim())}');
                  }
                },
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Feature Cards Section (matching web layout)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                FeatureCard(
                  title: 'Social',
                  description: 'See what\'s trending',
                  icon: Icons.people,
                  color: const Color(0xFF3B82F6),
                  onTap: () => context.push('/social'),
                ),
                FeatureCard(
                  title: 'Marketplace',
                  description: 'Featured items',
                  icon: Icons.shopping_bag,
                  color: const Color(0xFF10B981),
                  onTap: () => context.push('/marketplace'),
                ),
                FeatureCard(
                  title: 'Study Hub',
                  description: 'Upload & Share',
                  icon: Icons.book,
                  color: const Color(0xFF8B5CF6),
                  onTap: () => context.push('/notes'),
                ),
                FeatureCard(
                  title: 'Workspace',
                  description: 'Compete & Grow',
                  icon: Icons.work,
                  color: const Color(0xFFF59E0B),
                  onTap: () => context.push('/workspace'),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Hero Banner (matching web)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        const TextSpan(text: 'Join '),
                        TextSpan(
                          text: '10,000+ Students',
                          style: TextStyle(
                            foreground: Paint()
                              ..shader = const LinearGradient(
                                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                              ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                          ),
                        ),
                        const TextSpan(text: ' Already on UniNest 🎓'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'The ultimate platform to connect, study, and thrive with your peers. Stop missing out.',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => context.push('/signup'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Sign Up Free'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.push('/social'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Explore Community'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Impact Numbers (matching web)
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    value: '10K+',
                    label: 'Students Connected',
                    icon: Icons.school,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    value: '200+',
                    label: 'Vendors Onboarded',
                    icon: Icons.store,
                    color: const Color(0xFF10B981),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    value: '50+',
                    label: 'Libraries Managed',
                    icon: Icons.local_library,
                    color: const Color(0xFF8B5CF6),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Testimonials Section (matching web)
            Text(
              'Loved by Students Everywhere',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16),
            
            CarouselSlider(
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: true,
                viewportFraction: 0.9,
              ),
              items: const [
                TestimonialCard(
                  quote: "UniNest completely changed how I find study materials. The note sharing is a lifesaver, and I've connected with so many peers!",
                  name: "Fatima Khan",
                  school: "Jamia Millia Islamia",
                ),
                TestimonialCard(
                  quote: "The marketplace is brilliant. I sold all my old textbooks in a week and found a great deal on a used bike. It's so much better than other platforms.",
                  name: "John Mathew",
                  school: "St. Stephen's College",
                ),
                TestimonialCard(
                  quote: "As a fresher, UniNest helped me feel connected to the campus community instantly. The social feed is always buzzing with useful info.",
                  name: "Jaspreet Kaur",
                  school: "Guru Nanak Dev University",
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Growth Timeline Section (matching web)
            Text(
              'Our Journey So Far',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 24),
            
            const Column(
              children: [
                TimelineItem(
                  year: '2024',
                  title: 'The Vision',
                  description: 'Founded with a mission to simplify student life.',
                  icon: Icons.star,
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
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Closing CTA (matching web)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                    ).createShader(bounds),
                    child: Text(
                      'Don\'t Miss Out.',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Be part of the fastest-growing student movement and supercharge your campus life.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.push('/signup'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Get Started Now 🚀',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
