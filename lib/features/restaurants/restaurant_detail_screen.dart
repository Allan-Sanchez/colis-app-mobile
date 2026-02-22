import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/restaurant_provider.dart';
import '../../models/restaurant_social.dart';
import '../shared/widgets/location_map_widget.dart';
import '../shared/widgets/favorite_button.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final int restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantAsync = ref.watch(restaurantByIdProvider(restaurantId));
    final socialsAsync = ref.watch(restaurantSocialsByIdProvider(restaurantId));
    final locationsAsync =
        ref.watch(restaurantLocationsByIdProvider(restaurantId));

    return Scaffold(
      backgroundColor: Colors.white,
      body: restaurantAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorView(
          onRetry: () =>
              ref.invalidate(restaurantByIdProvider(restaurantId)),
        ),
        data: (restaurant) {
          if (restaurant == null) {
            return const Center(child: Text('Restaurante no encontrado'));
          }

          // Find WhatsApp number from socials
          final whatsappNumber = socialsAsync.whenOrNull(
            data: (socials) {
              final wa = socials.where(
                (s) => s.platform.toLowerCase() == 'whatsapp',
              );
              return wa.isEmpty ? null : wa.first.url;
            },
          );

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // Hero Section
                  SliverToBoxAdapter(
                    child: _HeroSection(
                      imageUrl: restaurant.imageUrl,
                      restaurantId: restaurantId,
                    ),
                  ),
                  // Content
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Name
                          Text(
                            restaurant.name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (restaurant.description != null) ...[
                            const SizedBox(height: 6),
                            Text(
                              restaurant.description!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          const SizedBox(height: 20),
                          // Description (if both exist)
                          const SizedBox(height: 4),
                          // Social icons
                          socialsAsync.when(
                            loading: () => const SizedBox.shrink(),
                            error: (_, __) => const SizedBox.shrink(),
                            data: (socials) {
                              if (socials.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Wrap(
                                spacing: 12,
                                children: socials
                                    .map((s) => _SocialIconButton(social: s))
                                    .toList(),
                              );
                            },
                          ),
                          const SizedBox(height: 28),
                          // Ver Menú CTA
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  context.push('/restaurants/$restaurantId/menu'),
                              icon: const Icon(Icons.menu_book_rounded),
                              label: const Text('Ver Menú'),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                textStyle: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                                shadowColor:
                                    AppColors.primary.withValues(alpha: 0.3),
                              ),
                            ),
                          ),
                          // Locations section
                          locationsAsync.when(
                            loading: () => const SizedBox.shrink(),
                            error: (_, __) => const SizedBox.shrink(),
                            data: (locations) {
                              if (locations.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 36),
                                  const Text(
                                    'Ubicaciones',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  ...locations.map(
                                    (location) => Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: LocationMapWidget(
                                        address: location.address,
                                        latitude: location.latitude,
                                        longitude: location.longitude,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Floating WhatsApp button
              if (whatsappNumber != null)
                Positioned(
                  bottom: 24,
                  right: 20,
                  child: _WhatsAppFab(number: whatsappNumber),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final String? imageUrl;
  final int restaurantId;

  const _HeroSection({required this.imageUrl, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.42,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with Hero shared element
          Hero(
            tag: 'restaurant_$restaurantId',
            child: imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        Container(color: AppColors.background),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      child: const Icon(Icons.restaurant,
                          size: 80, color: AppColors.primary),
                    ),
                  )
                : Container(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    child: const Icon(Icons.restaurant,
                        size: 80, color: AppColors.primary),
                  ),
          ),
          // Gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black38, Colors.transparent, Colors.transparent],
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),
          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3)),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white, size: 18),
              ),
            ),
          ),
          // Favorite button (top-right)
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 16,
            child: FavoriteButton(
              id: restaurantId,
              type: FavoriteType.restaurant,
            ),
          ),
          // Floating circular logo
          Positioned(
            bottom: -44,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 16,
                    ),
                  ],
                  color: Colors.white,
                ),
                clipBehavior: Clip.antiAlias,
                child: imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.restaurant,
                        size: 40, color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final RestaurantSocial social;

  const _SocialIconButton({required this.social});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(social.url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _getIcon(social.platform),
          size: 20,
          color: const Color(0xFF475569),
        ),
      ),
    );
  }

  IconData _getIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'facebook':
        return Icons.facebook_rounded;
      case 'instagram':
        return Icons.camera_alt_rounded;
      case 'whatsapp':
        return Icons.chat_rounded;
      case 'twitter':
      case 'x':
        return Icons.alternate_email_rounded;
      case 'tiktok':
        return Icons.music_note_rounded;
      case 'website':
      case 'web':
        return Icons.language_rounded;
      default:
        return Icons.link_rounded;
    }
  }
}

class _WhatsAppFab extends StatelessWidget {
  final String number;

  const _WhatsAppFab({required this.number});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final cleanNumber = number.replaceAll(RegExp(r'[^0-9+]'), '');
        final uri = Uri.parse('https://wa.me/$cleanNumber');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF25D366),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF25D366).withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.chat_rounded, color: Colors.white, size: 28),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_rounded,
                size: 64,
                color: AppColors.textSecondary.withValues(alpha: 0.4)),
            const SizedBox(height: 20),
            const Text(
              'Error al cargar',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      ),
    );
  }
}
