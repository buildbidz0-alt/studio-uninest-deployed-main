import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../services/payment_service.dart';
import '../../../core/utils/helpers.dart';

class DonateScreen extends ConsumerStatefulWidget {
  const DonateScreen({super.key});

  @override
  ConsumerState<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends ConsumerState<DonateScreen> {
  final List<int> _amounts = [50, 100, 250, 500, 1000];
  int? _selectedAmount;
  final _customAmountController = TextEditingController();
  late PaymentService _paymentService;

  @override
  void initState() {
    super.initState();
    _paymentService = PaymentService();
  }

  @override
  void dispose() {
    _customAmountController.dispose();
    _paymentService.dispose();
    super.dispose();
  }

  void _handleDonation() {
    final amount = _selectedAmount ?? double.tryParse(_customAmountController.text);
    
    if (amount == null || amount <= 0) {
      Helpers.showSnackBar(context, 'Please enter a valid amount', isError: true);
      return;
    }

    _paymentService.initiatePayment(
      amount: amount.toDouble(),
      description: 'Donation to UniNest',
      email: 'user@example.com', // TODO: Get from user profile
      contact: '9999999999', // TODO: Get from user profile
      onSuccess: (response) {
        Helpers.showSnackBar(context, 'Thank you for your donation! 🎉');
        Navigator.pop(context);
      },
      onFailure: (response) {
        Helpers.showSnackBar(
          context,
          'Payment failed: ${response.message}',
          isError: true,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Support UniNest'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(Icons.favorite, color: Colors.white, size: 48),
                  SizedBox(height: 16),
                  Text(
                    'Help Us Grow',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your support helps us build a better platform for students',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Quick amounts
            Text(
              'Select Amount',
              style: theme.textTheme.headlineMedium,
            ),
            
            const SizedBox(height: 16),
            
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _amounts.map((amount) {
                final isSelected = _selectedAmount == amount;
                return ChoiceChip(
                  label: Text('₹$amount'),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedAmount = selected ? amount : null;
                      _customAmountController.clear();
                    });
                  },
                );
              }).toList(),
            ),
            
            const SizedBox(height: 24),
            
            // Custom amount
            Text(
              'Or Enter Custom Amount',
              style: theme.textTheme.titleMedium,
            ),
            
            const SizedBox(height: 12),
            
            TextField(
              controller: _customAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixText: '₹',
                hintText: 'Enter amount',
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() => _selectedAmount = null);
                }
              },
            ),
            
            const SizedBox(height: 32),
            
            // Impact section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Impact',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ImpactItem(
                    icon: Icons.cloud,
                    text: 'Server and hosting costs',
                  ),
                  _ImpactItem(
                    icon: Icons.build,
                    text: 'New features and improvements',
                  ),
                  _ImpactItem(
                    icon: Icons.support_agent,
                    text: 'Better customer support',
                  ),
                  _ImpactItem(
                    icon: Icons.school,
                    text: 'Free access for all students',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Donate button
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _handleDonation,
                child: const Text('Donate Now 💝'),
              ),
            ),
            
            const SizedBox(height: 16),
            
            Text(
              'All donations are secure and processed through Razorpay',
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ImpactItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ImpactItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
