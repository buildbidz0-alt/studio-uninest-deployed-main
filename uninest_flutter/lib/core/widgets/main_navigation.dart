import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';

class MainNavigation extends StatefulWidget {
  final Widget child;

  const MainNavigation({
    super.key,
    required this.child,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      route: RouteNames.home,
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    NavigationItem(
      route: RouteNames.social,
      icon: Icons.people_outline,
      activeIcon: Icons.people,
      label: 'Social',
    ),
    NavigationItem(
      route: RouteNames.marketplace,
      icon: Icons.shopping_bag_outlined,
      activeIcon: Icons.shopping_bag,
      label: 'Market',
    ),
    NavigationItem(
      route: RouteNames.notes,
      icon: Icons.book_outlined,
      activeIcon: Icons.book,
      label: 'Notes',
    ),
    NavigationItem(
      route: RouteNames.workspace,
      icon: Icons.work_outline,
      activeIcon: Icons.work,
      label: 'Work',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentLocation = GoRouterState.of(context).uri.path;
    
    // Update current index based on route
    final routeIndex = _navigationItems.indexWhere(
      (item) => item.route == currentLocation,
    );
    if (routeIndex != -1 && routeIndex != _currentIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _currentIndex = routeIndex;
        });
      });
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            context.go(_navigationItems[index].route);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: theme.colorScheme.surface,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          items: _navigationItems.map((item) {
            final isSelected = _navigationItems.indexOf(item) == _currentIndex;
            return BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: isSelected
                    ? BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      )
                    : null,
                child: Icon(
                  isSelected ? item.activeIcon : item.icon,
                  size: 24,
                ),
              ),
              label: item.label,
            );
          }).toList(),
        ),
      ),
      drawer: _buildDrawer(context),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          // Header
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Welcome to UniNest!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your campus companion',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(
                  icon: Icons.feed,
                  title: 'Feed',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(RouteNames.feed);
                  },
                ),
                _DrawerItem(
                  icon: Icons.search,
                  title: 'Search',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(RouteNames.search);
                  },
                ),
                _DrawerItem(
                  icon: Icons.bed,
                  title: 'Hostels',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(RouteNames.hostels);
                  },
                ),
                _DrawerItem(
                  icon: Icons.chat,
                  title: 'Chat',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(RouteNames.chat);
                  },
                ),
                const Divider(),
                _DrawerItem(
                  icon: Icons.dashboard,
                  title: 'Vendor Dashboard',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(RouteNames.vendorDashboard);
                  },
                ),
                _DrawerItem(
                  icon: Icons.admin_panel_settings,
                  title: 'Admin Panel',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(RouteNames.admin);
                  },
                ),
                const Divider(),
                _DrawerItem(
                  icon: Icons.favorite,
                  title: 'Donate',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(RouteNames.donate);
                  },
                ),
                _DrawerItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(RouteNames.settings);
                  },
                ),
                _DrawerItem(
                  icon: Icons.help,
                  title: 'Support',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(RouteNames.support);
                  },
                ),
                _DrawerItem(
                  icon: Icons.info,
                  title: 'About',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(RouteNames.about);
                  },
                ),
                _DrawerItem(
                  icon: Icons.description,
                  title: 'Terms & Conditions',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(RouteNames.terms);
                  },
                ),
              ],
            ),
          ),
          
          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Divider(),
                Row(
                  children: [
                    Icon(
                      Icons.school,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'UniNest v1.0.0',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}

class NavigationItem {
  final String route;
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavigationItem({
    required this.route,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
