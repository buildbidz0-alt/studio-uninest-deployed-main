import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('About UniNest'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo and Name
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.school,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                    ).createShader(bounds),
                    child: Text(
                      AppConstants.appName,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppConstants.appTagline,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Mission Section
            _SectionCard(
              title: 'Our Mission',
              content: 'UniNest is dedicated to creating a comprehensive digital ecosystem for students. We aim to simplify campus life by providing a unified platform for social networking, marketplace transactions, academic resources, and career opportunities.',
              icon: Icons.flag,
              color: Colors.blue,
            ),
            
            const SizedBox(height: 20),
            
            // Features Section
            _SectionCard(
              title: 'What We Offer',
              content: '',
              icon: Icons.star,
              color: Colors.orange,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FeatureItem(
                    icon: Icons.people,
                    title: 'Social Networking',
                    description: 'Connect with peers, join study groups, and build lasting friendships.',
                  ),
                  _FeatureItem(
                    icon: Icons.shopping_bag,
                    title: 'Student Marketplace',
                    description: 'Buy and sell textbooks, electronics, and other student essentials.',
                  ),
                  _FeatureItem(
                    icon: Icons.bed,
                    title: 'Hostel Services',
                    description: 'Find and book comfortable accommodation near your campus.',
                  ),
                  _FeatureItem(
                    icon: Icons.work,
                    title: 'Career Opportunities',
                    description: 'Discover internships, competitions, and job opportunities.',
                  ),
                  _FeatureItem(
                    icon: Icons.book,
                    title: 'Academic Resources',
                    description: 'Share notes, form study groups, and access learning materials.',
                  ),
                  _FeatureItem(
                    icon: Icons.support_agent,
                    title: '24/7 Support',
                    description: 'Get help whenever you need it with our dedicated support team.',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Statistics Section
            _SectionCard(
              title: 'Our Impact',
              content: '',
              icon: Icons.analytics,
              color: Colors.green,
              child: Row(
                children: [
                  Expanded(
                    child: _StatItem(
                      value: '${AppConstants.studentsCount}+',
                      label: 'Students',
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: _StatItem(
                      value: '${AppConstants.vendorsCount}+',
                      label: 'Vendors',
                      color: Colors.green,
                    ),
                  ),
                  Expanded(
                    child: _StatItem(
                      value: '${AppConstants.librariesCount}+',
                      label: 'Services',
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Team Section
            _SectionCard(
              title: 'Our Team',
              content: 'UniNest is built by a passionate team of students and developers who understand the challenges of campus life. We\'re committed to continuously improving the platform based on user feedback and emerging needs.',
              icon: Icons.group,
              color: Colors.purple,
            ),
            
            const SizedBox(height: 20),
            
            // Contact Section
            _SectionCard(
              title: 'Get in Touch',
              content: '',
              icon: Icons.contact_mail,
              color: Colors.teal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ContactItem(
                    icon: Icons.email,
                    title: 'Email Support',
                    subtitle: AppConstants.supportEmail,
                    onTap: () => _launchEmail(),
                  ),
                  const SizedBox(height: 12),
                  _ContactItem(
                    icon: Icons.language,
                    title: 'Website',
                    subtitle: 'www.uninest.com',
                    onTap: () => _launchWebsite(),
                  ),
                  const SizedBox(height: 12),
                  _ContactItem(
                    icon: Icons.camera_alt,
                    title: 'Instagram',
                    subtitle: '@uninest_x',
                    onTap: () => _launchInstagram(),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Version Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Text(
                    'Version 1.0.0',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Built with ❤️ for students',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => _launchUrl(AppConstants.termsUrl),
                        child: const Text('Terms of Service'),
                      ),
                      TextButton(
                        onPressed: () => _launchUrl(AppConstants.privacyUrl),
                        child: const Text('Privacy Policy'),
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

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: AppConstants.supportEmail,
      query: 'subject=UniNest App Support',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchWebsite() async {
    await _launchUrl('https://www.uninest.com');
  }

  void _launchInstagram() async {
    await _launchUrl('https://www.instagram.com/uninest_x');
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color color;
  final Widget? child;

  const _SectionCard({
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (content.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              content,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.6,
              ),
            ),
          ],
          if (child != null) ...[
            const SizedBox(height: 16),
            child!,
          ],
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
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
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
