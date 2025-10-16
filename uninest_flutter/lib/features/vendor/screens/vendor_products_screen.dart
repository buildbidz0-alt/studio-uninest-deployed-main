import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';

class VendorProductsScreen extends ConsumerStatefulWidget {
  const VendorProductsScreen({super.key});

  @override
  ConsumerState<VendorProductsScreen> createState() => _VendorProductsScreenState();
}

class _VendorProductsScreenState extends ConsumerState<VendorProductsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Engineering Textbook',
      category: 'Books',
      price: 450.0,
      stock: 5,
      status: ProductStatus.active,
      imageUrl: '',
      description: 'Complete engineering mathematics textbook',
    ),
    Product(
      id: '2',
      name: 'Hostel Room - Single',
      category: 'Hostels',
      price: 8000.0,
      stock: 2,
      status: ProductStatus.active,
      imageUrl: '',
      description: 'Single occupancy hostel room with AC',
    ),
    Product(
      id: '3',
      name: 'Monthly Mess Plan',
      category: 'Food Mess',
      price: 3500.0,
      stock: 50,
      status: ProductStatus.draft,
      imageUrl: '',
      description: 'Complete monthly food mess subscription',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _filteredProducts {
    if (_searchQuery.isEmpty) return _products;
    return _products.where((product) =>
        product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        product.category.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Active'),
            Tab(text: 'Draft'),
            Tab(text: 'Inactive'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: theme.colorScheme.surface,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
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
          ),
          
          // Products List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductsList(_filteredProducts),
                _buildProductsList(_filteredProducts.where((p) => p.status == ProductStatus.active).toList()),
                _buildProductsList(_filteredProducts.where((p) => p.status == ProductStatus.draft).toList()),
                _buildProductsList(_filteredProducts.where((p) => p.status == ProductStatus.inactive).toList()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddProductDialog();
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
    );
  }

  Widget _buildProductsList(List<Product> products) {
    if (products.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No products found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Add your first product to get started',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _ProductCard(
          product: product,
          onEdit: () => _editProduct(product),
          onDelete: () => _deleteProduct(product),
          onToggleStatus: () => _toggleProductStatus(product),
        );
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Products'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Add filter options here
            const Text('Filter options coming soon...'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Product'),
        content: const Text('Product creation form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _editProduct(Product product) {
    // Navigate to edit product screen
  }

  void _deleteProduct(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${product.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Delete product logic
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _toggleProductStatus(Product product) {
    // Toggle product status logic
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleStatus;

  const _ProductCard({
    required this.product,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Product Image
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
                
                const SizedBox(width: 16),
                
                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.category,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${product.price.toStringAsFixed(0)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(product.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(product.status),
                    style: TextStyle(
                      color: _getStatusColor(product.status),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Description
            Text(
              product.description,
              style: theme.textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 12),
            
            // Stock and Actions
            Row(
              children: [
                Icon(Icons.inventory, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  'Stock: ${product.stock}',
                  style: theme.textTheme.bodySmall,
                ),
                
                const Spacer(),
                
                // Action Buttons
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 20),
                  tooltip: 'Edit',
                ),
                IconButton(
                  onPressed: onToggleStatus,
                  icon: Icon(
                    product.status == ProductStatus.active
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 20,
                  ),
                  tooltip: product.status == ProductStatus.active
                      ? 'Deactivate'
                      : 'Activate',
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(ProductStatus status) {
    switch (status) {
      case ProductStatus.active:
        return Colors.green;
      case ProductStatus.draft:
        return Colors.orange;
      case ProductStatus.inactive:
        return Colors.red;
    }
  }

  String _getStatusText(ProductStatus status) {
    switch (status) {
      case ProductStatus.active:
        return 'Active';
      case ProductStatus.draft:
        return 'Draft';
      case ProductStatus.inactive:
        return 'Inactive';
    }
  }
}

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final int stock;
  final ProductStatus status;
  final String imageUrl;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.status,
    required this.imageUrl,
    required this.description,
  });
}

enum ProductStatus {
  active,
  draft,
  inactive,
}
