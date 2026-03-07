import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/api_constants.dart';
import '../../providers/restaurant_provider.dart';
import '../../providers/directory_provider.dart';
import '../../providers/notifications_provider.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/featured_restaurants_carousel.dart';
import 'widgets/category_grid.dart';
import 'widgets/featured_businesses_section.dart';
import 'widgets/notifications_sheet.dart';
import 'widgets/about_sheet.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestNotificationPermission();
    });
  }

  Future<void> _requestNotificationPermission() async {
    try {
      final messaging = FirebaseMessaging.instance;
      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        final token = await messaging.getToken();
        if (token != null) {
          Dio(BaseOptions(baseUrl: ApiConstants.baseUrl))
              .post(ApiConstants.deviceTokens, data: {
            'fcmToken': token,
            'platform': 'android',
            'interests': ['restaurants', 'directory'],
          }).catchError((_) {});
        }
      }
    } catch (_) {}
  }

  Future<void> _onRefresh() async {
    ref.invalidate(featuredRestaurantsHomeProvider);
    ref.invalidate(directoryCategoriesProvider);
    ref.invalidate(featuredProfilesHomeProvider);
    await Future.wait([
      ref.read(featuredRestaurantsHomeProvider.future),
      ref.read(directoryCategoriesProvider.future),
      ref.read(featuredProfilesHomeProvider.future),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header — siempre visible, sin estado de carga
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hola, ¿qué buscas hoy?',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Explora lo mejor de tu ciudad en Colis.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const _NotificationBell(),
                          const SizedBox(width: 8),
                          const _InfoButton(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SearchBarWidget(),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                // Cada sección carga y muestra su shimmer de forma independiente
                const _RestaurantsSection(),
                const SizedBox(height: 28),
                const _CategoriesSection(),
                const SizedBox(height: 28),
                const _BusinessesSection(),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Secciones independientes — cada una gestiona su propio estado de carga
// ---------------------------------------------------------------------------

class _RestaurantsSection extends ConsumerWidget {
  const _RestaurantsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(featuredRestaurantsHomeProvider);
    return state.when(
      skipLoadingOnReload: true,
      loading: () => const _RestaurantsShimmer(),
      error: (_, __) => _SectionError(
        onRetry: () => ref.invalidate(featuredRestaurantsHomeProvider),
      ),
      data: (restaurants) => FeaturedRestaurantsCarousel(restaurants: restaurants),
    );
  }
}

class _CategoriesSection extends ConsumerWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(directoryCategoriesProvider);
    return state.when(
      skipLoadingOnReload: true,
      loading: () => const _CategoriesShimmer(),
      error: (_, __) => _SectionError(
        onRetry: () => ref.invalidate(directoryCategoriesProvider),
      ),
      data: (categories) => CategoryGrid(categories: categories),
    );
  }
}

class _BusinessesSection extends ConsumerWidget {
  const _BusinessesSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(featuredProfilesHomeProvider);
    return state.when(
      skipLoadingOnReload: true,
      loading: () => const _BusinessesShimmer(),
      error: (_, __) => _SectionError(
        onRetry: () => ref.invalidate(featuredProfilesHomeProvider),
      ),
      data: (businesses) => FeaturedBusinessesSection(businesses: businesses),
    );
  }
}

// ---------------------------------------------------------------------------
// Shimmer por sección
// ---------------------------------------------------------------------------

Widget _shimmerBox(double w, double h, {double radius = 8}) => Container(
      width: w == double.infinity ? null : w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

class _RestaurantsShimmer extends StatelessWidget {
  const _RestaurantsShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[50]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _shimmerBox(180, 22),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 3,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (_, _) => _shimmerBox(260, 220, radius: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesShimmer extends StatelessWidget {
  const _CategoriesShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[50]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _shimmerBox(180, 22),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3.2,
              ),
              itemCount: 4,
              itemBuilder: (_, _) => _shimmerBox(double.infinity, 48, radius: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _BusinessesShimmer extends StatelessWidget {
  const _BusinessesShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[50]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _shimmerBox(160, 22),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 4,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (_, _) => _shimmerBox(160, 180, radius: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Error inline por sección
// ---------------------------------------------------------------------------

class _SectionError extends StatelessWidget {
  final VoidCallback onRetry;

  const _SectionError({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 18,
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'No se pudo cargar',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ),
          GestureDetector(
            onTap: onRetry,
            child: const Text(
              'Reintentar',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Widgets de header (sin cambios)
// ---------------------------------------------------------------------------

class _NotificationBell extends ConsumerWidget {
  const _NotificationBell();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(unreadCountProvider);
    return GestureDetector(
      onTap: () {
        ref.read(notificationsProvider.notifier).markAllRead();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const NotificationsSheet(),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              count > 0 ? Icons.notifications_rounded : Icons.notifications_none_rounded,
              size: 18,
              color: AppColors.textPrimary,
            ),
          ),
          if (count > 0)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  count > 9 ? '9+' : '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoButton extends StatelessWidget {
  const _InfoButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const AboutSheet(),
        );
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.info_outline_rounded, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}
