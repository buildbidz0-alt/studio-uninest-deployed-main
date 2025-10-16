import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';

class HostelsScreen extends ConsumerStatefulWidget {
  const HostelsScreen({super.key});

  @override
  ConsumerState<HostelsScreen> createState() => _HostelsScreenState();
}

class _HostelsScreenState extends ConsumerState<HostelsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  
  final List<String> _filters = ['All', 'Boys', 'Girls', 'AC', 'Non-AC', 'Available'];

  final List<Hostel> _hostels = [
    Hostel(
      id: '1',
      name: 'Sunrise Boys Hostel',
      type: HostelType.boys,
      hasAC: true,
      pricePerMonth: 8000,
      availableRooms: 5,
      totalRooms: 50,
      rating: 4.5,
      imageUrl: '',
      amenities: ['WiFi', 'Mess', 'Laundry', 'Security', 'Parking'],
      address: 'Near Engineering College, Sector 15',
      description: 'Modern hostel with all amenities for engineering students.',
    ),
    Hostel(
      id: '2',
      name: 'Green Valley Girls Hostel',
      type: HostelType.girls,
      hasAC: false,
      pricePerMonth: 6500,
      availableRooms: 8,
      totalRooms: 40,
      rating: 4.2,
      imageUrl: '',
      amenities: ['WiFi', 'Mess', 'Laundry', 'Security', 'Garden'],
      address: 'University Road, Block A',
      description: 'Safe and comfortable accommodation for female students.',
    ),
    Hostel(
      id: '3',
      name: 'Tech Hub Hostel',
      type: HostelType.boys,
      hasAC: true,
      pricePerMonth: 9500,
      availableRooms: 2,
      totalRooms: 60,
      rating: 4.7,
      imageUrl: '',
      amenities: ['WiFi', 'Mess', 'Gym', 'Study Room', 'Gaming Zone'],
      address: 'IT Park Road, Phase 2',
      description: 'Premium hostel with modern facilities and high-speed internet.',
    ),
  ];

  List<Hostel> get _filteredHostels {
    List<Hostel> filtered = _hostels;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((hostel) =>
          hostel.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          hostel.address.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    // Apply category filter
    if (_selectedFilter != 'All') {
      switch (_selectedFilter) {
        case 'Boys':
          filtered = filtered.where((h) => h.type == HostelType.boys).toList();
          break;
        case 'Girls':
          filtered = filtered.where((h) => h.type == HostelType.girls).toList();
          break;
        case 'AC':
          filtered = filtered.where((h) => h.hasAC).toList();
          break;
        case 'Non-AC':
          filtered = filtered.where((h) => !h.hasAC).toList();
          break;
        case 'Available':
          filtered = filtered.where((h) => h.availableRooms > 0).toList();
          break;
      }
    }

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh hostels data
        },
        child: CustomScrollView(
          slivers: [
            // Header Section
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find Your Perfect Hostel',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Comfortable, safe, and affordable accommodation for students',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Search Bar
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search hostels by name or location...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.background,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Filter Chips
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _filters.length,
                        itemBuilder: (context, index) {
                          final filter = _filters[index];
                          final isSelected = _selectedFilter == filter;
                          
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(filter),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedFilter = selected ? filter : 'All';
                                });
                              },
                              backgroundColor: theme.colorScheme.surface,
                              selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                              checkmarkColor: theme.colorScheme.primary,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Stats Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatsCard(
                        title: 'Total Hostels',
                        value: _hostels.length.toString(),
                        icon: Icons.home,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatsCard(
                        title: 'Available Rooms',
                        value: _hostels.fold(0, (sum, h) => sum + h.availableRooms).toString(),
                        icon: Icons.bed,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatsCard(
                        title: 'Starting From',
                        value: '₹${_hostels.map((h) => h.pricePerMonth).reduce((a, b) => a < b ? a : b).toStringAsFixed(0)}',
                        icon: Icons.currency_rupee,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Hostels List
            _filteredHostels.isEmpty
                ? const SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No hostels found',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try adjusting your search or filters',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final hostel = _filteredHostels[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _HostelCard(
                              hostel: hostel,
                              onTap: () => _showHostelDetails(hostel),
                              onBook: () => _bookHostel(hostel),
                            ),
                          );
                        },
                        childCount: _filteredHostels.length,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _showHostelDetails(Hostel hostel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _HostelDetailsSheet(hostel: hostel),
    );
  }

  void _bookHostel(Hostel hostel) {
    if (hostel.availableRooms == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No rooms available in this hostel'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book ${hostel.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: ₹${hostel.pricePerMonth}/month'),
            const SizedBox(height: 8),
            Text('Available rooms: ${hostel.availableRooms}'),
            const SizedBox(height: 16),
            const Text('Booking form will be implemented here.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Booking request sent for ${hostel.name}'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Book Now'),
          ),
        ],
      ),
    );
  }
}

class _HostelCard extends StatelessWidget {
  final Hostel hostel;
  final VoidCallback onTap;
  final VoidCallback onBook;

  const _HostelCard({
    required this.hostel,
    required this.onTap,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.image, size: 48, color: Colors.grey),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getTypeColor(hostel.type).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getTypeText(hostel.type),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (hostel.hasAC)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'AC',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Content Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          hostel.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            hostel.rating.toString(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          hostel.address,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Text(
                    hostel.description,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Amenities
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: hostel.amenities.take(3).map((amenity) => 
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          amenity,
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₹${hostel.pricePerMonth.toStringAsFixed(0)}/month',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${hostel.availableRooms} rooms available',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: hostel.availableRooms > 0 ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: hostel.availableRooms > 0 ? onBook : null,
                        child: Text(hostel.availableRooms > 0 ? 'Book Now' : 'Full'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(HostelType type) {
    switch (type) {
      case HostelType.boys:
        return Colors.blue;
      case HostelType.girls:
        return Colors.pink;
    }
  }

  String _getTypeText(HostelType type) {
    switch (type) {
      case HostelType.boys:
        return 'Boys';
      case HostelType.girls:
        return 'Girls';
    }
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

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _HostelDetailsSheet extends StatelessWidget {
  final Hostel hostel;

  const _HostelDetailsSheet({required this.hostel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hostel.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Image placeholder
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.image, size: 48, color: Colors.grey),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    'Description',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(hostel.description),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    'Amenities',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: hostel.amenities.map((amenity) => 
                      Chip(
                        label: Text(amenity),
                        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                      ),
                    ).toList(),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    'Details',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _DetailRow('Type', _getTypeText(hostel.type)),
                  _DetailRow('AC', hostel.hasAC ? 'Yes' : 'No'),
                  _DetailRow('Price', '₹${hostel.pricePerMonth.toStringAsFixed(0)}/month'),
                  _DetailRow('Available Rooms', '${hostel.availableRooms}/${hostel.totalRooms}'),
                  _DetailRow('Rating', '${hostel.rating}/5.0'),
                  _DetailRow('Address', hostel.address),
                ],
              ),
            ),
          ),
          
          // Book Button
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: hostel.availableRooms > 0 ? () {
                  Navigator.pop(context);
                  // Handle booking
                } : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  hostel.availableRooms > 0 
                      ? 'Book Now - ₹${hostel.pricePerMonth.toStringAsFixed(0)}/month'
                      : 'No Rooms Available',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTypeText(HostelType type) {
    switch (type) {
      case HostelType.boys:
        return 'Boys Hostel';
      case HostelType.girls:
        return 'Girls Hostel';
    }
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

class Hostel {
  final String id;
  final String name;
  final HostelType type;
  final bool hasAC;
  final double pricePerMonth;
  final int availableRooms;
  final int totalRooms;
  final double rating;
  final String imageUrl;
  final List<String> amenities;
  final String address;
  final String description;

  Hostel({
    required this.id,
    required this.name,
    required this.type,
    required this.hasAC,
    required this.pricePerMonth,
    required this.availableRooms,
    required this.totalRooms,
    required this.rating,
    required this.imageUrl,
    required this.amenities,
    required this.address,
    required this.description,
  });
}

enum HostelType {
  boys,
  girls,
}
