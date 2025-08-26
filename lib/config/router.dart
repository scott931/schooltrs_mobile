import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/user.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/role_selection_screen.dart';
import '../screens/parent/parent_dashboard.dart';
import '../screens/driver/driver_dashboard.dart';
import '../screens/parent/children_screen.dart';
import '../screens/parent/live_map_screen.dart';
import '../screens/parent/payments_screen.dart';
import '../screens/parent/notifications_screen.dart';
import '../screens/parent/settings_screen.dart';
import '../screens/driver/routes_screen.dart';
import '../screens/driver/students_screen.dart';
import '../screens/driver/inspection_screen.dart';
import '../screens/driver/incidents_screen.dart';
import '../screens/driver/messages_screen.dart';
import '../screens/driver/notifications_screen.dart';
import '../screens/driver/settings_screen.dart';

// Global key for router refresh
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      // If user is authenticated and on splash/onboarding, redirect to appropriate dashboard
      if (authProvider.isAuthenticated &&
          (state.matchedLocation == '/' ||
              state.matchedLocation == '/onboarding')) {
        final user = authProvider.user;
        if (user?.role == UserRole.parent) {
          return '/parent';
        } else if (user?.role == UserRole.driver) {
          return '/driver';
        }
      }

      // If user is not authenticated and trying to access protected routes, redirect to auth
      if (!authProvider.isAuthenticated &&
          !state.matchedLocation.startsWith('/auth') &&
          state.matchedLocation != '/' &&
          state.matchedLocation != '/onboarding') {
        return '/auth';
      }

      return null;
    },
    routes: [
      // Splash and onboarding
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Authentication routes
      GoRoute(
        path: '/auth',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/signup',
        builder: (context, state) => const SignupScreen(),
      ),

      // Parent routes
      GoRoute(
        path: '/parent',
        builder: (context, state) => const ParentDashboard(),
      ),
      GoRoute(
        path: '/parent/children',
        builder: (context, state) => const ChildrenScreen(),
      ),
      GoRoute(
        path: '/parent/live-map',
        builder: (context, state) => const LiveMapScreen(),
      ),
      GoRoute(
        path: '/parent/payments',
        builder: (context, state) => const PaymentsScreen(),
      ),
      GoRoute(
        path: '/parent/notifications',
        builder: (context, state) => const ParentNotificationsScreen(),
      ),
      GoRoute(
        path: '/parent/settings',
        builder: (context, state) => const ParentSettingsScreen(),
      ),

      // Driver routes
      GoRoute(
        path: '/driver',
        builder: (context, state) => const DriverDashboard(),
      ),
      GoRoute(
        path: '/driver/routes',
        builder: (context, state) => const RoutesScreen(),
      ),
      GoRoute(
        path: '/driver/students',
        builder: (context, state) => const StudentsScreen(),
      ),
      GoRoute(
        path: '/driver/inspection',
        builder: (context, state) => const InspectionScreen(),
      ),
      GoRoute(
        path: '/driver/incidents',
        builder: (context, state) => const IncidentsScreen(),
      ),
      GoRoute(
        path: '/driver/messages',
        builder: (context, state) => const DriverMessagesScreen(),
      ),
      GoRoute(
        path: '/driver/notifications',
        builder: (context, state) => const DriverNotificationsScreen(),
      ),
      GoRoute(
        path: '/driver/settings',
        builder: (context, state) => const DriverSettingsScreen(),
      ),
    ],
  );

  // Method to refresh the router
  static void refresh() {
    _rootNavigatorKey.currentState?.pushReplacementNamed('/');
  }
}
