import 'package:go_router/go_router.dart';
import 'features/splash/splash_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/role_selection_screen.dart';
import 'features/profile/model_profile_setup_screen.dart';
import 'features/profile/brand_profile_setup_screen.dart';
import 'features/discovery/discovery_screen.dart';
import 'features/matches/matches_screen.dart';
import 'features/chat/chat_list_screen.dart';
import 'features/chat/chat_screen.dart';
import 'features/premium/premium_upsell_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/admin/admin_dashboard_screen.dart';
import 'widgets/bottom_nav_scaffold.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/role', builder: (_, __) => const RoleSelectionScreen()),
      GoRoute(path: '/setup/model', builder: (_, __) => const ModelProfileSetupScreen()),
      GoRoute(path: '/setup/brand', builder: (_, __) => const BrandProfileSetupScreen()),
      GoRoute(path: '/premium', builder: (_, __) => const PremiumUpsellScreen()),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      GoRoute(path: '/admin', builder: (_, __) => const AdminDashboardScreen()),
      GoRoute(path: '/chat/:matchId', builder: (_, state) {
        final matchId = state.pathParameters['matchId']!;
        return ChatScreen(matchId: matchId);
      }),
      GoRoute(
        path: '/home',
        builder: (_, __) => const BottomNavScaffold(),
      ),
    ],
  );
}
