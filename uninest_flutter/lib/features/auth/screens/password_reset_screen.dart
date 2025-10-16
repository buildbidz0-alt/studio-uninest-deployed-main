import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/helpers.dart';

class PasswordResetScreen extends ConsumerStatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  ConsumerState<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends ConsumerState<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handlePasswordReset() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Simulate password reset API call
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _emailSent = true;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent! Check your inbox.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send reset email: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _resendEmail() async {
    setState(() => _isLoading = true);
    
    try {
      // Simulate resend API call
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reset email sent again!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to resend email: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: _emailSent ? _buildEmailSentView() : _buildResetForm(),
        ),
      ),
    );
  }

  Widget _buildResetForm() {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          
          // Icon
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.lock_reset,
              size: 50,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Title
          Text(
            'Forgot Password?',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            'Don\'t worry! Enter your email address and we\'ll send you a link to reset your password.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.textTheme.bodyMedium?.color,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 40),
          
          // Email field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email Address',
              hintText: 'Enter your registered email',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email address';
              }
              if (!Helpers.isValidEmail(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 32),
          
          // Reset button
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handlePasswordReset,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Send Reset Link',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Back to login
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Remember your password? ',
                style: theme.textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: () => context.go(RouteNames.login),
                child: const Text('Sign In'),
              ),
            ],
          ),
          
          const SizedBox(height: 40),
          
          // Help section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.help_outline,
                  color: theme.colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(height: 12),
                Text(
                  'Need Help?',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'If you\'re having trouble resetting your password, please contact our support team.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    // Navigate to support
                  },
                  child: const Text('Contact Support'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailSentView() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 40),
        
        // Success Icon
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(
            Icons.mark_email_read,
            size: 50,
            color: Colors.green,
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Title
        Text(
          'Check Your Email',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 16),
        
        // Description
        Text(
          'We\'ve sent a password reset link to:',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.textTheme.bodyMedium?.color,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 8),
        
        Text(
          _emailController.text,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 32),
        
        // Instructions
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Next Steps:',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _InstructionItem(
                number: '1',
                text: 'Check your email inbox (and spam folder)',
              ),
              _InstructionItem(
                number: '2',
                text: 'Click the reset link in the email',
              ),
              _InstructionItem(
                number: '3',
                text: 'Create a new password',
              ),
              _InstructionItem(
                number: '4',
                text: 'Sign in with your new password',
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Resend button
        OutlinedButton(
          onPressed: _isLoading ? null : _resendEmail,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text(
                  'Resend Email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
        ),
        
        const SizedBox(height: 16),
        
        // Back to login
        TextButton(
          onPressed: () => context.go(RouteNames.login),
          child: const Text('Back to Sign In'),
        ),
        
        const SizedBox(height: 32),
        
        // Didn't receive email section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                Icons.warning_amber_outlined,
                color: Colors.orange,
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                'Didn\'t receive the email?',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Check your spam folder or try resending the email. If you still don\'t receive it, contact support.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.orange,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InstructionItem extends StatelessWidget {
  final String number;
  final String text;

  const _InstructionItem({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
