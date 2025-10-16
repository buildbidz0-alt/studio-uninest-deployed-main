import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terms & Conditions',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Last updated: December 2024',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Introduction
            _TermsSection(
              title: '1. Introduction',
              content: 'Welcome to ${AppConstants.appName}. These Terms and Conditions ("Terms") govern your use of our mobile application and services. By accessing or using our app, you agree to be bound by these Terms.',
            ),
            
            _TermsSection(
              title: '2. Acceptance of Terms',
              content: 'By creating an account or using our services, you acknowledge that you have read, understood, and agree to be bound by these Terms. If you do not agree to these Terms, please do not use our services.',
            ),
            
            _TermsSection(
              title: '3. User Accounts',
              content: '''• You must provide accurate and complete information when creating an account
• You are responsible for maintaining the security of your account credentials
• You must be at least 16 years old to use our services
• One person may not maintain more than one account
• You are responsible for all activities that occur under your account''',
            ),
            
            _TermsSection(
              title: '4. Marketplace Services',
              content: '''• Users can buy and sell items through our marketplace
• We are not responsible for the quality, safety, or legality of items listed
• All transactions are between buyers and sellers directly
• We reserve the right to remove listings that violate our policies
• Payment processing is handled by third-party providers''',
            ),
            
            _TermsSection(
              title: '5. Hostel and Accommodation Services',
              content: '''• Hostel listings are provided by third-party vendors
• We do not guarantee the availability or quality of accommodations
• Booking confirmations and cancellations are subject to vendor policies
• Users must comply with hostel rules and regulations
• We are not liable for any issues arising from accommodation bookings''',
            ),
            
            _TermsSection(
              title: '6. User Content and Conduct',
              content: '''• You retain ownership of content you post, but grant us license to use it
• You must not post illegal, harmful, or offensive content
• Harassment, bullying, or discrimination is strictly prohibited
• Spam, fake accounts, or misleading information is not allowed
• We reserve the right to remove content and suspend accounts for violations''',
            ),
            
            _TermsSection(
              title: '7. Privacy and Data Protection',
              content: '''• Your privacy is important to us - see our Privacy Policy for details
• We collect and use data to provide and improve our services
• We do not sell personal information to third parties
• You can request deletion of your account and associated data
• We implement security measures to protect your information''',
            ),
            
            _TermsSection(
              title: '8. Intellectual Property',
              content: '''• The app and its content are protected by copyright and other laws
• You may not copy, modify, or distribute our intellectual property
• User-generated content remains the property of the respective users
• We respect intellectual property rights and expect users to do the same''',
            ),
            
            _TermsSection(
              title: '9. Limitation of Liability',
              content: '''• Our services are provided "as is" without warranties
• We are not liable for indirect, incidental, or consequential damages
• Our total liability is limited to the amount you paid for our services
• Some jurisdictions do not allow certain limitations, so these may not apply to you''',
            ),
            
            _TermsSection(
              title: '10. Termination',
              content: '''• You may terminate your account at any time
• We may suspend or terminate accounts for Terms violations
• Upon termination, your right to use the services ceases immediately
• Some provisions of these Terms survive termination''',
            ),
            
            _TermsSection(
              title: '11. Changes to Terms',
              content: '''• We may update these Terms from time to time
• Significant changes will be communicated through the app
• Continued use after changes constitutes acceptance
• You should review Terms periodically for updates''',
            ),
            
            _TermsSection(
              title: '12. Contact Information',
              content: '''If you have questions about these Terms, please contact us:

Email: ${AppConstants.supportEmail}
Website: www.uninest.com

We aim to respond to all inquiries within 48 hours.''',
            ),
            
            const SizedBox(height: 24),
            
            // Footer
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
                  Icon(
                    Icons.gavel,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Legal Compliance',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'These terms are governed by the laws of India. Any disputes will be resolved in the courts of New Delhi.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigate to Privacy Policy
                        },
                        child: const Text('Privacy Policy'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to Support
                        },
                        child: const Text('Contact Support'),
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

class _TermsSection extends StatelessWidget {
  final String title;
  final String content;

  const _TermsSection({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
