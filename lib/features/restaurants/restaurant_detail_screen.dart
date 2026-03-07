import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/restaurant_provider.dart';
import '../shared/widgets/location_map_widget.dart';
import '../shared/widgets/favorite_button.dart';
import '../shared/widgets/social_tile.dart';
import '../shared/widgets/upgrade_plan_modal.dart';
import '../shared/widgets/reviews_section.dart';
import '../../../providers/dio_provider.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final int restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  ConsumerState<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends ConsumerState<RestaurantDetailScreen> {
  bool _viewTracked = false;

  void _track(String eventType) {
    ref.read(analyticsRepositoryProvider).track(
      entityType: 'restaurant',
      entityId: widget.restaurantId,
      eventType: eventType,
    );
  }

  @override
  Widget build(BuildContext context) {
    final restaurantId = widget.restaurantId;
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

          // Track view once
          if (!_viewTracked) {
            _viewTracked = true;
            WidgetsBinding.instance.addPostFrameCallback((_) => _track('view'));
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
                          // Social links
                          socialsAsync.when(
                            loading: () => const SizedBox.shrink(),
                            error: (_, __) => const SizedBox.shrink(),
                            data: (socials) {
                              final filtered = socials
                                  .where((s) =>
                                      s.platform.toLowerCase() != 'whatsapp')
                                  .toList();
                              if (filtered.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  const _SectionTitle(
                                    icon: Icons.share_rounded,
                                    label: 'Redes Sociales',
                                  ),
                                  const SizedBox(height: 12),
                                  ...filtered.map((s) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: SocialTile(
                                          platform: s.platform,
                                          url: s.url,
                                        ),
                                      )),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 28),
                          // Upgrade plan CTA (solo si es free)
                          if (restaurant.planTier == 'free') ...[
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () => showUpgradePlanModal(
                                  context,
                                  entityId: restaurant.id,
                                  entityName: restaurant.name,
                                  entityType: 'restaurant',
                                  currentPlanTier: restaurant.planTier,
                                ),
                                icon: const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 18),
                                label: const Text(
                                  'Mejorar Visibilidad',
                                  style: TextStyle(color: Color(0xFFF59E0B), fontWeight: FontWeight.w700),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  side: const BorderSide(color: Color(0xFFF59E0B)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
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
                          // Servicios (delivery, dine-in, takeout)
                          if (restaurant.hasDelivery || restaurant.hasDineIn || restaurant.hasTakeout) ...[
                            const SizedBox(height: 28),
                            const _SectionTitle(
                              icon: Icons.room_service_rounded,
                              label: 'Servicios',
                            ),
                            const SizedBox(height: 12),
                            _ChipRow(chips: [
                              if (restaurant.hasDelivery)
                                const _ServiceChip(
                                  icon: Icons.delivery_dining_rounded,
                                  label: 'A domicilio',
                                ),
                              if (restaurant.hasDineIn)
                                const _ServiceChip(
                                  icon: Icons.restaurant_rounded,
                                  label: 'En local',
                                ),
                              if (restaurant.hasTakeout)
                                const _ServiceChip(
                                  icon: Icons.takeout_dining_rounded,
                                  label: 'Para llevar',
                                ),
                            ]),
                          ],
                          // Rango de precios
                          if (restaurant.priceRange != null) ...[
                            const SizedBox(height: 24),
                            _InfoRow(
                              icon: Icons.attach_money_rounded,
                              label: 'Rango de precios',
                              value: restaurant.priceRange!
                                  .replaceAll('\$', 'Q'),
                            ),
                          ],
                          // Horario
                          if (restaurant.openingHours != null) ...[
                            const SizedBox(height: 16),
                            _InfoRow(
                              icon: Icons.schedule_rounded,
                              label: 'Horario',
                              value: restaurant.openingHours!,
                            ),
                          ],
                          // Etiquetas
                          if (restaurant.tags != null && restaurant.tags!.isNotEmpty) ...[
                            const SizedBox(height: 24),
                            const _SectionTitle(
                              icon: Icons.label_rounded,
                              label: 'Etiquetas',
                            ),
                            const SizedBox(height: 12),
                            _ChipRow(chips: restaurant.tags!
                                .map((t) => _LabelChip(label: t))
                                .toList()),
                          ],
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
                          // Reviews section
                          ReviewsSection(
                            entityType: 'restaurant',
                            entityId: restaurantId,
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
                  child: _WhatsAppFab(
                    number: whatsappNumber,
                    onTap: () => _track('whatsapp_click'),
                  ),
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

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SectionTitle({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _WhatsAppFab extends StatelessWidget {
  final String number;
  final VoidCallback? onTap;

  const _WhatsAppFab({required this.number, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        onTap?.call();
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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  final List<Widget> chips;

  const _ChipRow({required this.chips});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips,
    );
  }
}

class _ServiceChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ServiceChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _LabelChip extends StatelessWidget {
  final String label;

  const _LabelChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
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
