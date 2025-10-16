import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  final List<SearchResult> _recentSearches = [
    SearchResult(
      id: '1',
      title: 'Engineering Mathematics',
      subtitle: 'Textbook by R.K. Jain',
      type: SearchResultType.product,
      imageUrl: '',
    ),
    SearchResult(
      id: '2',
      title: 'John Doe',
      subtitle: 'Computer Science Student',
      type: SearchResultType.user,
      imageUrl: '',
    ),
    SearchResult(
      id: '3',
      title: 'Study Group - Data Structures',
      subtitle: 'Active group with 15 members',
      type: SearchResultType.group,
      imageUrl: '',
    ),
  ];

  final List<SearchResult> _trendingSearches = [
    SearchResult(
      id: '4',
      title: 'Hostel Room Single',
      subtitle: 'Trending in Marketplace',
      type: SearchResultType.product,
      imageUrl: '',
    ),
    SearchResult(
      id: '5',
      title: 'Coding Competition',
      subtitle: 'Trending in Workspace',
      type: SearchResultType.event,
      imageUrl: '',
    ),
    SearchResult(
      id: '6',
      title: 'Library Seats',
      subtitle: 'Trending in Services',
      type: SearchResultType.service,
      imageUrl: '',
    ),
  ];

  List<SearchResult> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search UniNest...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey.shade600),
          ),
          style: theme.textTheme.titleMedium,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
              _isSearching = value.isNotEmpty;
            });
            _performSearch(value);
          },
          onSubmitted: (value) {
            _performSearch(value);
          },
        ),
        actions: [
          if (_searchQuery.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                  _isSearching = false;
                  _searchResults.clear();
                });
              },
            ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
        bottom: _isSearching
            ? TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'People'),
                  Tab(text: 'Products'),
                  Tab(text: 'Groups'),
                  Tab(text: 'Events'),
                  Tab(text: 'Services'),
                ],
              )
            : null,
      ),
      body: _isSearching ? _buildSearchResults() : _buildDefaultContent(),
    );
  }

  Widget _buildDefaultContent() {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Actions
          Text(
            'Quick Actions',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3,
            children: [
              _QuickActionCard(
                icon: Icons.shopping_bag,
                title: 'Marketplace',
                onTap: () {
                  // Navigate to marketplace
                },
              ),
              _QuickActionCard(
                icon: Icons.people,
                title: 'Find Friends',
                onTap: () {
                  // Navigate to people search
                },
              ),
              _QuickActionCard(
                icon: Icons.bed,
                title: 'Hostels',
                onTap: () {
                  // Navigate to hostels
                },
              ),
              _QuickActionCard(
                icon: Icons.work,
                title: 'Opportunities',
                onTap: () {
                  // Navigate to workspace
                },
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Recent Searches
          if (_recentSearches.isNotEmpty) ...[
            Row(
              children: [
                Text(
                  'Recent Searches',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _recentSearches.clear();
                    });
                  },
                  child: const Text('Clear All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...._recentSearches.map((result) => _SearchResultTile(
              result: result,
              onTap: () => _handleResultTap(result),
              trailing: IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () {
                  setState(() {
                    _recentSearches.remove(result);
                  });
                },
              ),
            )),
            
            const SizedBox(height: 32),
          ],
          
          // Trending Searches
          Text(
            'Trending',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...._trendingSearches.map((result) => _SearchResultTile(
            result: result,
            onTap: () => _handleResultTap(result),
            trailing: const Icon(Icons.trending_up, color: Colors.orange),
          )),
          
          const SizedBox(height: 32),
          
          // Search Tips
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Search Tips',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('• Use specific keywords for better results'),
                const Text('• Search for people by name or course'),
                const Text('• Find products by category or price range'),
                const Text('• Discover study groups and events'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty && _searchQuery.isNotEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Try different keywords or check spelling',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return TabBarView(
      controller: _tabController,
      children: [
        _buildResultsList(_searchResults),
        _buildResultsList(_searchResults.where((r) => r.type == SearchResultType.user).toList()),
        _buildResultsList(_searchResults.where((r) => r.type == SearchResultType.product).toList()),
        _buildResultsList(_searchResults.where((r) => r.type == SearchResultType.group).toList()),
        _buildResultsList(_searchResults.where((r) => r.type == SearchResultType.event).toList()),
        _buildResultsList(_searchResults.where((r) => r.type == SearchResultType.service).toList()),
      ],
    );
  }

  Widget _buildResultsList(List<SearchResult> results) {
    if (results.isEmpty) {
      return const Center(
        child: Text(
          'No results in this category',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return _SearchResultTile(
          result: result,
          onTap: () => _handleResultTap(result),
        );
      },
    );
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    // Simulate search results
    setState(() {
      _searchResults = [
        SearchResult(
          id: 'search_1',
          title: 'Engineering Mathematics Textbook',
          subtitle: '₹450 • Excellent condition',
          type: SearchResultType.product,
          imageUrl: '',
        ),
        SearchResult(
          id: 'search_2',
          title: 'Sarah Johnson',
          subtitle: 'Computer Science • 3rd Year',
          type: SearchResultType.user,
          imageUrl: '',
        ),
        SearchResult(
          id: 'search_3',
          title: 'Data Structures Study Group',
          subtitle: '12 members • Meets Tuesdays',
          type: SearchResultType.group,
          imageUrl: '',
        ),
        SearchResult(
          id: 'search_4',
          title: 'Coding Competition 2024',
          subtitle: 'Starts Dec 15 • ₹50,000 prize',
          type: SearchResultType.event,
          imageUrl: '',
        ),
      ].where((result) => 
        result.title.toLowerCase().contains(query.toLowerCase()) ||
        result.subtitle.toLowerCase().contains(query.toLowerCase())
      ).toList();
    });
  }

  void _handleResultTap(SearchResult result) {
    // Add to recent searches if not already there
    if (!_recentSearches.any((r) => r.id == result.id)) {
      setState(() {
        _recentSearches.insert(0, result);
        if (_recentSearches.length > 5) {
          _recentSearches.removeLast();
        }
      });
    }

    // Navigate based on result type
    switch (result.type) {
      case SearchResultType.user:
        // Navigate to user profile
        break;
      case SearchResultType.product:
        // Navigate to product details
        break;
      case SearchResultType.group:
        // Navigate to group details
        break;
      case SearchResultType.event:
        // Navigate to event details
        break;
      case SearchResultType.service:
        // Navigate to service details
        break;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Filters'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Filter options will be implemented here.'),
            const SizedBox(height: 16),
            // Add filter options like price range, category, etc.
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
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                icon,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final SearchResult result;
  final VoidCallback onTap;
  final Widget? trailing;

  const _SearchResultTile({
    required this.result,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: _getTypeColor(result.type).withOpacity(0.1),
        child: Icon(
          _getTypeIcon(result.type),
          color: _getTypeColor(result.type),
          size: 20,
        ),
      ),
      title: Text(
        result.title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(result.subtitle),
      trailing: trailing ?? Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey.shade400,
      ),
    );
  }

  Color _getTypeColor(SearchResultType type) {
    switch (type) {
      case SearchResultType.user:
        return Colors.blue;
      case SearchResultType.product:
        return Colors.green;
      case SearchResultType.group:
        return Colors.orange;
      case SearchResultType.event:
        return Colors.purple;
      case SearchResultType.service:
        return Colors.teal;
    }
  }

  IconData _getTypeIcon(SearchResultType type) {
    switch (type) {
      case SearchResultType.user:
        return Icons.person;
      case SearchResultType.product:
        return Icons.shopping_bag;
      case SearchResultType.group:
        return Icons.group;
      case SearchResultType.event:
        return Icons.event;
      case SearchResultType.service:
        return Icons.business;
    }
  }
}

class SearchResult {
  final String id;
  final String title;
  final String subtitle;
  final SearchResultType type;
  final String imageUrl;

  SearchResult({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.imageUrl,
  });
}

enum SearchResultType {
  user,
  product,
  group,
  event,
  service,
}
