import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';

class VendorDashboardScreen extends ConsumerStatefulWidget {
  const VendorDashboardScreen({super.key});

  @override
  ConsumerState<VendorDashboardScreen> createState() => _VendorDashboardScreenState();
}

class _VendorDashboardScreenState extends ConsumerState<VendorDashboardScreen> {
  final List<VendorService> _services = [
    VendorService(
      id: 'library',
      name: 'Library Hub',
      icon: Icons.library_books,
      color: Colors.purple,
      description: 'Manage your library services, view specific orders, and see detailed analytics.',
    ),
    VendorService(
      id: 'food-mess',
      name: 'Food Mess Hub',
      icon: Icons.restaurant,
      color: Colors.orange,
      description: 'Manage your food mess services, view specific orders, and see detailed analytics.',
    ),
    VendorService(
      id: 'hostels',
      name: 'Hostel Hub',
      icon: Icons.bed,
      color: Colors.blue,
      description: 'Manage your hostel services, view specific orders, and see detailed analytics.',
    ),
    VendorService(
      id: 'cybercafe',
      name: 'Cybercafé Hub',
      icon: Icons.computer,
      color: Colors.green,
      description: 'Manage your cybercafé services, view specific orders, and see detailed analytics.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Dashboard'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to vendor settings
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
                gradient: LinearGradient(
                  colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, Vendor!',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Here\'s your main hub to manage all your services.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _StatsCard(
                    title: 'Total Orders',
                    value: '156',
                    icon: Icons.shopping_bag,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatsCard(
                    title: 'Revenue',
                    value: '₹45,230',
                    icon: Icons.currency_rupee,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _StatsCard(
                    title: 'Active Products',
                    value: '23',
                    icon: Icons.inventory,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatsCard(
                    title: 'Pending Orders',
                    value: '8',
                    icon: Icons.pending_actions,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Service Dashboards
            Text(
              'Your Service Dashboards',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                return _ServiceCard(service: service);
              },
            ),
            
            const SizedBox(height: 32),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to add product
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Product'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Navigate to orders
                    },
                    icon: const Icon(Icons.list_alt),
                    label: const Text('View Orders'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VendorService {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final String description;

  VendorService({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
  });
}

class _ServiceCard extends StatelessWidget {
  final VendorService service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Navigate to specific service dashboard
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: service.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      service.icon,
                      color: service.color,
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                service.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  service.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatsCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '+12%',
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
