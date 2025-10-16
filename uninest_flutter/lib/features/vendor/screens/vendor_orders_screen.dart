import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class VendorOrdersScreen extends ConsumerStatefulWidget {
  const VendorOrdersScreen({super.key});

  @override
  ConsumerState<VendorOrdersScreen> createState() => _VendorOrdersScreenState();
}

class _VendorOrdersScreenState extends ConsumerState<VendorOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Order> _orders = [
    Order(
      id: 'ORD001',
      customerName: 'John Doe',
      productName: 'Engineering Textbook',
      amount: 450.0,
      status: OrderStatus.pending,
      orderDate: DateTime.now().subtract(const Duration(hours: 2)),
      customerEmail: 'john@example.com',
      quantity: 1,
    ),
    Order(
      id: 'ORD002',
      customerName: 'Jane Smith',
      productName: 'Monthly Mess Plan',
      amount: 3500.0,
      status: OrderStatus.confirmed,
      orderDate: DateTime.now().subtract(const Duration(days: 1)),
      customerEmail: 'jane@example.com',
      quantity: 1,
    ),
    Order(
      id: 'ORD003',
      customerName: 'Mike Johnson',
      productName: 'Hostel Room - Single',
      amount: 8000.0,
      status: OrderStatus.completed,
      orderDate: DateTime.now().subtract(const Duration(days: 3)),
      customerEmail: 'mike@example.com',
      quantity: 1,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Order> get _filteredOrders {
    if (_searchQuery.isEmpty) return _orders;
    return _orders.where((order) =>
        order.customerName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        order.productName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        order.id.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh orders
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending'),
            Tab(text: 'Confirmed'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
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
                hintText: 'Search orders...',
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
          
          // Orders Stats
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _StatsCard(
                    title: 'Total Orders',
                    value: _orders.length.toString(),
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatsCard(
                    title: 'Pending',
                    value: _orders.where((o) => o.status == OrderStatus.pending).length.toString(),
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatsCard(
                    title: 'Revenue',
                    value: '₹${_orders.fold(0.0, (sum, order) => sum + order.amount).toStringAsFixed(0)}',
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          
          // Orders List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList(_filteredOrders),
                _buildOrdersList(_filteredOrders.where((o) => o.status == OrderStatus.pending).toList()),
                _buildOrdersList(_filteredOrders.where((o) => o.status == OrderStatus.confirmed).toList()),
                _buildOrdersList(_filteredOrders.where((o) => o.status == OrderStatus.completed).toList()),
                _buildOrdersList(_filteredOrders.where((o) => o.status == OrderStatus.cancelled).toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Order> orders) {
    if (orders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No orders found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Orders will appear here when customers make purchases',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _OrderCard(
          order: order,
          onTap: () => _showOrderDetails(order),
          onUpdateStatus: (status) => _updateOrderStatus(order, status),
        );
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Orders'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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

  void _showOrderDetails(Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order ${order.id}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow('Customer', order.customerName),
            _DetailRow('Email', order.customerEmail),
            _DetailRow('Product', order.productName),
            _DetailRow('Quantity', order.quantity.toString()),
            _DetailRow('Amount', '₹${order.amount.toStringAsFixed(0)}'),
            _DetailRow('Status', _getStatusText(order.status)),
            _DetailRow('Date', DateFormat('dd MMM yyyy, hh:mm a').format(order.orderDate)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (order.status == OrderStatus.pending)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _updateOrderStatus(order, OrderStatus.confirmed);
              },
              child: const Text('Confirm Order'),
            ),
        ],
      ),
    );
  }

  void _updateOrderStatus(Order order, OrderStatus newStatus) {
    setState(() {
      final index = _orders.indexWhere((o) => o.id == order.id);
      if (index != -1) {
        _orders[index] = order.copyWith(status: newStatus);
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order ${order.id} updated to ${_getStatusText(newStatus)}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;
  final Function(OrderStatus) onUpdateStatus;

  const _OrderCard({
    required this.order,
    required this.onTap,
    required this.onUpdateStatus,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ${order.id}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          order.customerName,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStatusText(order.status),
                      style: TextStyle(
                        color: _getStatusColor(order.status),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              Text(
                order.productName,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Row(
                children: [
                  Icon(Icons.currency_rupee, size: 16, color: Colors.green),
                  Text(
                    order.amount.toStringAsFixed(0),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('dd MMM, hh:mm a').format(order.orderDate),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              
              if (order.status == OrderStatus.pending) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => onUpdateStatus(OrderStatus.cancelled),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => onUpdateStatus(OrderStatus.confirmed),
                        child: const Text('Confirm'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class _StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatsCard({
    required this.title,
    required this.value,
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
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
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
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
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

class Order {
  final String id;
  final String customerName;
  final String customerEmail;
  final String productName;
  final double amount;
  final OrderStatus status;
  final DateTime orderDate;
  final int quantity;

  Order({
    required this.id,
    required this.customerName,
    required this.customerEmail,
    required this.productName,
    required this.amount,
    required this.status,
    required this.orderDate,
    required this.quantity,
  });

  Order copyWith({
    String? id,
    String? customerName,
    String? customerEmail,
    String? productName,
    double? amount,
    OrderStatus? status,
    DateTime? orderDate,
    int? quantity,
  }) {
    return Order(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      productName: productName ?? this.productName,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      orderDate: orderDate ?? this.orderDate,
      quantity: quantity ?? this.quantity,
    );
  }
}

enum OrderStatus {
  pending,
  confirmed,
  completed,
  cancelled,
}
