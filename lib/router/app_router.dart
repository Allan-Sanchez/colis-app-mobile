import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/splash/splash_screen.dart';
import '../features/home/home_screen.dart';
import '../features/restaurants/restaurants_list_screen.dart';
import '../features/restaurants/restaurant_detail_screen.dart';
import '../features/directory/directory_screen.dart';
import '../features/directory/business_detail_screen.dart';
import '../features/directory/category_businesses_screen.dart';
import '../features/menu/menu_screen.dart';
import '../features/search/search_screen.dart';
import '../features/favorites/favorites_screen.dart';
import '../features/cart/cart_screen.dart';
import '../features/cart/order_summary_screen.dart';
import '../features/cart/order_confirmation_screen.dart';
import '../features/shared/shell_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Slide-from-right + fade transition for detail screens (280 ms).
Page<void> _slideFadePage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final slide = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

      final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(0.0, 0.5),
        ),
      );

      return SlideTransition(
        position: slide,
        child: FadeTransition(opacity: fade, child: child),
      );
    },
  );
}

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKey,
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/restaurants',
              builder: (context, state) => const RestaurantsListScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/directory',
              builder: (context, state) => const DirectoryScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),
      ],
    ),
    // Detail routes (without bottom nav) — slide + fade transition
    GoRoute(
      path: '/restaurants/:id',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return _slideFadePage(
          state: state,
          child: RestaurantDetailScreen(restaurantId: id),
        );
      },
    ),
    GoRoute(
      path: '/restaurants/:id/menu',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return _slideFadePage(
          state: state,
          child: MenuScreen(restaurantId: id),
        );
      },
    ),
    GoRoute(
      path: '/directory/category/:id',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return _slideFadePage(
          state: state,
          child: CategoryBusinessesScreen(categoryId: id),
        );
      },
    ),
    GoRoute(
      path: '/directory/business/:id',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return _slideFadePage(
          state: state,
          child: BusinessDetailScreen(profileId: id),
        );
      },
    ),
    GoRoute(
      path: '/cart',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => _slideFadePage(
        state: state,
        child: const CartScreen(),
      ),
    ),
    GoRoute(
      path: '/cart/summary',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => _slideFadePage(
        state: state,
        child: const OrderSummaryScreen(),
      ),
    ),
    GoRoute(
      path: '/order/:id/confirmation',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return _slideFadePage(
          state: state,
          child: OrderConfirmationScreen(orderId: id),
        );
      },
    ),
  ],
);
