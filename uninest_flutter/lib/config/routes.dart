import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_constants.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
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
import '../core/widgets/main_layout.dart';

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
    
    // Main app routes (with bottom nav)
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
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
  ],
);
