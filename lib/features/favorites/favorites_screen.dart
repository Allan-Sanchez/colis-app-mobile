import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/favorites_provider.dart';
import '../../providers/restaurant_provider.dart';
import '../../providers/directory_provider.dart';
import '../shared/widgets/favorite_button.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(favoritesProvider);
    final hasAny =
        state.restaurantIds.isNotEmpty || state.businessIds.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background.withValues(alpha: 0.95),
        elevation: 0,
        title: const Text(
          'Favoritos',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: !hasAny
          ? _EmptyFavorites()
          : AnimationLimiter(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                children: [
                  // ── Restaurants ──────────────────────────────────────────
                  if (state.restaurantIds.isNotEmpty) ...[
                    _SectionHeader(
                      icon: Icons.restaurant_rounded,
                      label: 'Restaurantes',
                      count: state.restaurantIds.length,
                    ),
                    const SizedBox(height: 12),
                    ...state.restaurantIds.toList().asMap().entries.map(
                          (e) => AnimationConfiguration.staggeredList(
                            position: e.key,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 24.0,
                              child: FadeInAnimation(
                                child: _RestaurantFavoriteCard(
                                    restaurantId: e.value),
                              ),
                            ),
                          ),
                        ),
                    const SizedBox(height: 24),
                  ],
                  // ── Businesses ───────────────────────────────────────────
                  if (state.businessIds.isNotEmpty) ...[
                    _SectionHeader(
                      icon: Icons.store_rounded,
                      label: 'Negocios',
                      count: state.businessIds.length,
                    ),
                    const SizedBox(height: 12),
                    ...state.businessIds.toList().asMap().entries.map(
                          (e) => AnimationConfiguration.staggeredList(
                            position: e.key,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 24.0,
                              child: FadeInAnimation(
                                child:
                                    _BusinessFavoriteCard(profileId: e.value),
                              ),
                            ),
                          ),
                        ),
                  ],
                ],
              ),
            ),
    );
  }
}

// ─── Empty State ────────────────────────────────────────────────────────────

class _EmptyFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 80,
            color: AppColors.textSecondary.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 20),
          const Text(
            'Aún no tienes favoritos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Toca el ❤️ en cualquier restaurante\no negocio para guardarlo aquí.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section Header ─────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;

  const _SectionHeader({
    required this.icon,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, color: AppColors.primary, size: 18),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$count',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Restaurant Card ─────────────────────────────────────────────────────────

class _RestaurantFavoriteCard extends ConsumerWidget {
  final int restaurantId;

  const _RestaurantFavoriteCard({required this.restaurantId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(restaurantByIdProvider(restaurantId));

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: async.when(
        loading: () => _CardSkeleton(),
        error: (_, __) => const SizedBox.shrink(),
        data: (restaurant) {
          if (restaurant == null) return const SizedBox.shrink();
          return GestureDetector(
            onTap: () => context.push('/restaurants/$restaurantId'),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 72,
                      height: 72,
                      child: restaurant.imageUrl != null
                          ? CachedNetworkImage(
                              imageUrl: restaurant.imageUrl!,
                              fit: BoxFit.cover,
                              placeholder: (_, __) =>
                                  Container(color: AppColors.background),
                              errorWidget: (_, __, ___) => Container(
                                color: AppColors.background,
                                child: const Icon(Icons.restaurant,
                                    color: AppColors.textSecondary),
                              ),
                            )
                          : Container(
                              color: AppColors.background,
                              child: const Icon(Icons.restaurant,
                                  color: AppColors.textSecondary),
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (restaurant.description != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            restaurant.description!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  FavoriteButton(
                    id: restaurantId,
                    type: FavoriteType.restaurant,
                    showBackground: false,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Business Card ───────────────────────────────────────────────────────────

class _BusinessFavoriteCard extends ConsumerWidget {
  final int profileId;

  const _BusinessFavoriteCard({required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(profileByIdProvider(profileId));

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: async.when(
        loading: () => _CardSkeleton(),
        error: (_, __) => const SizedBox.shrink(),
        data: (profile) {
          if (profile == null) return const SizedBox.shrink();
          return GestureDetector(
            onTap: () => context.push('/directory/business/$profileId'),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 72,
                      height: 72,
                      child: profile.imageUrl != null
                          ? CachedNetworkImage(
                              imageUrl: profile.imageUrl!,
                              fit: BoxFit.cover,
                              placeholder: (_, __) =>
                                  Container(color: AppColors.background),
                              errorWidget: (_, __, ___) => Container(
                                color: AppColors.background,
                                child: const Icon(Icons.store,
                                    color: AppColors.textSecondary),
                              ),
                            )
                          : Container(
                              color: AppColors.background,
                              child: const Icon(Icons.store,
                                  color: AppColors.textSecondary),
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (profile.description != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            profile.description!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  FavoriteButton(
                    id: profileId,
                    type: FavoriteType.business,
                    showBackground: false,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Skeleton ────────────────────────────────────────────────────────────────

class _CardSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
    );
  }
}
