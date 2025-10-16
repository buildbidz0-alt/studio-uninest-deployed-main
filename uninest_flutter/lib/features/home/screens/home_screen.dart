import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../config/theme.dart';
import '../../../core/constants/app_constants.dart';
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
                            onPressed: () => context.push(RouteNames.signup),
                            child: const Text('Sign Up Free'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => context.push(RouteNames.social),
                            child: const Text('Explore'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Stats
              const Row(
                children: [
                  Expanded(
                    child: StatCard(
                      value: AppConstants.studentsCount,
                      label: 'Students Connected',
                      icon: Icons.school,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      value: AppConstants.vendorsCount,
                      label: 'Vendors',
                      icon: Icons.store,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              const StatCard(
                value: AppConstants.librariesCount,
                label: 'Libraries Managed',
                icon: Icons.local_library,
              ),
              
              const SizedBox(height: 32),
              
              // Testimonials
              Text(
                'Loved by Students Everywhere',
                style: theme.textTheme.displaySmall,
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
                    quote: "UniNest completely changed how I find study materials. The note sharing is a lifesaver!",
                    name: "Fatima Khan",
                    school: "Jamia Millia Islamia",
                  ),
                  TestimonialCard(
                    quote: "The marketplace is brilliant. I sold all my old textbooks in a week!",
                    name: "John Mathew",
                    school: "St. Stephen's College",
                  ),
                  TestimonialCard(
                    quote: "As a fresher, UniNest helped me feel connected to the campus community instantly.",
                    name: "Jaspreet Kaur",
                    school: "Guru Nanak Dev University",
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Timeline
              Text(
                'Our Journey So Far',
                style: theme.textTheme.displaySmall,
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
              
              // Final CTA
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
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
                      shaderCallback: (bounds) =>
                          AppTheme.primaryGradient.createShader(bounds),
                      child: Text(
                        'Don\'t Miss Out.',
                        style: theme.textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Be part of the fastest-growing student movement and supercharge your campus life.',
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => context.push(RouteNames.signup),
                        child: const Text('Get Started Now 🚀'),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
