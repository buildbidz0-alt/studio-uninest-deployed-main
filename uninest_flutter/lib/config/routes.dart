import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_constants.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/auth/screens/password_reset_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/social/screens/social_screen.dart';
import '../features/marketplace/screens/marketplace_screen.dart';
import '../features/notes/screens/notes_screen.dart';
import '../features/workspace/screens/workspace_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/chat/screens/chat_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../features/admin/screens/admin_dashboard_screen.dart';
import '../features/donate/screens/donate_screen.dart';
import '../features/support/screens/support_screen.dart';
import '../features/about/screens/about_screen.dart';
import '../features/terms/screens/terms_screen.dart';
import '../features/feed/screens/feed_screen.dart';
import '../features/search/screens/search_screen.dart';
import '../features/hostels/screens/hostels_screen.dart';
import '../features/vendor/screens/vendor_dashboard_screen.dart';
import '../features/vendor/screens/vendor_products_screen.dart';
import '../features/vendor/screens/vendor_orders_screen.dart';
import '../core/widgets/main_navigation.dart';

final router = GoRouter(
  initialLocation: RouteNames.home,
  routes: [
    // Auth routes (no bottom nav)
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteNames.signup,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: RouteNames.passwordReset,
      builder: (context, state) => const PasswordResetScreen(),
    ),
    
    // Main app routes (with bottom nav)
    ShellRoute(
      builder: (context, state, child) => MainNavigation(child: child),
      routes: [
        GoRoute(
          path: RouteNames.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RouteNames.social,
          builder: (context, state) => const SocialScreen(),
        ),
        GoRoute(
          path: RouteNames.marketplace,
          builder: (context, state) => const MarketplaceScreen(),
        ),
        GoRoute(
          path: RouteNames.notes,
          builder: (context, state) => const NotesScreen(),
        ),
        GoRoute(
          path: RouteNames.workspace,
          builder: (context, state) => const WorkspaceScreen(),
        ),
        GoRoute(
          path: RouteNames.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: RouteNames.chat,
          builder: (context, state) => const ChatScreen(),
        ),
      ],
    ),
    
    // Standalone routes (with back button, no bottom nav)
    GoRoute(
      path: RouteNames.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: RouteNames.admin,
      builder: (context, state) => const AdminDashboardScreen(),
    ),
    GoRoute(
      path: RouteNames.donate,
      builder: (context, state) => const DonateScreen(),
    ),
    GoRoute(
      path: RouteNames.support,
      builder: (context, state) => const SupportScreen(),
    ),
    GoRoute(
      path: RouteNames.about,
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: RouteNames.terms,
      builder: (context, state) => const TermsScreen(),
    ),
    GoRoute(
      path: RouteNames.feed,
      builder: (context, state) => const FeedScreen(),
    ),
    GoRoute(
      path: RouteNames.search,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: RouteNames.hostels,
      builder: (context, state) => const HostelsScreen(),
    ),
    GoRoute(
      path: RouteNames.vendorDashboard,
      builder: (context, state) => const VendorDashboardScreen(),
    ),
    GoRoute(
      path: RouteNames.vendorProducts,
      builder: (context, state) => const VendorProductsScreen(),
    ),
    GoRoute(
      path: RouteNames.vendorOrders,
      builder: (context, state) => const VendorOrdersScreen(),
    ),
  ],
);
