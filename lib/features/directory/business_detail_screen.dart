import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/directory_provider.dart';
import '../shared/widgets/location_map_widget.dart';
import '../shared/widgets/favorite_button.dart';

class BusinessDetailScreen extends ConsumerWidget {
  final int profileId;

  const BusinessDetailScreen({super.key, required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileByIdProvider(profileId));
    final contactsAsync = ref.watch(profileContactsByIdProvider(profileId));
    final locationsAsync = ref.watch(profileLocationsByIdProvider(profileId));
    final socialsAsync = ref.watch(profileSocialsByIdProvider(profileId));

    return Scaffold(
      backgroundColor: Colors.white,
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_rounded, size: 56,
                  color: AppColors.textSecondary.withValues(alpha: 0.4)),
              const SizedBox(height: 16),
              const Text('Error al cargar negocio'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.invalidate(profileByIdProvider(profileId)),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('Negocio no encontrado'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Cover + logo
                _CoverSection(
                  imageUrl: profile.imageUrl,
                  name: profile.name,
                  description: profile.description,
                  profileId: profileId,
                ),
                // Socials
                socialsAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (socials) {
                    if (socials.isEmpty) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Wrap(
                        spacing: 12,
                        children: socials.map((social) {
                          return GestureDetector(
                            onTap: () => _launchUrl(social.url),
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF1F5F9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _socialIcon(social.platform),
                                size: 20,
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Contact section
                      contactsAsync.when(
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                        data: (contacts) {
                          if (contacts.isEmpty) return const SizedBox.shrink();
                          final items = <Widget>[];
                          for (final c in contacts) {
                            if (c.phoneNumber != null) {
                              items.add(_ContactTile(
                                icon: Icons.phone_rounded,
                                label: 'Llámanos',
                                value: c.phoneNumber!,
                                onTap: () =>
                                    _launchUrl('tel:${c.phoneNumber}'),
                              ));
                            }
                            if (c.email != null) {
                              items.add(_ContactTile(
                                icon: Icons.mail_rounded,
                                label: 'Email',
                                value: c.email!,
                                onTap: () =>
                                    _launchUrl('mailto:${c.email}'),
                              ));
                            }
                          }
                          if (items.isEmpty) return const SizedBox.shrink();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _SectionTitle(
                                icon: Icons.contact_support_rounded,
                                label: 'Contacto',
                              ),
                              const SizedBox(height: 12),
                              ...items.map((w) => Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: w,
                                  )),
                              const SizedBox(height: 24),
                            ],
                          );
                        },
                      ),
                      // Location section
                      locationsAsync.when(
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                        data: (locations) {
                          if (locations.isEmpty) return const SizedBox.shrink();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _SectionTitle(
                                icon: Icons.location_on_rounded,
                                label: 'Ubicaciones',
                              ),
                              const SizedBox(height: 12),
                              ...locations.map((location) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: LocationMapWidget(
                                      address: location.address,
                                      latitude: location.latitude,
                                      longitude: location.longitude,
                                    ),
                                  )),
                            ],
                          );
                        },
                      ),
                      // Verified banner
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.1),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.verified_rounded,
                                color: AppColors.primary),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Negocio Verificado',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Este negocio ha verificado sus datos con Colis.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _socialIcon(String platform) {
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
      case 'website':
      case 'web':
        return Icons.language_rounded;
      default:
        return Icons.link_rounded;
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _CoverSection extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String? description;
  final int profileId;

  const _CoverSection({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.profileId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cover image
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: 220,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'business_$profileId',
                    child: imageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: imageUrl!,
                            fit: BoxFit.cover,
                            placeholder: (_, __) =>
                                Container(color: AppColors.background),
                            errorWidget: (_, __, ___) => Container(
                              color: AppColors.primary.withValues(alpha: 0.1),
                            ),
                          )
                        : Container(
                            color: AppColors.primary.withValues(alpha: 0.1),
                          ),
                  ),
                  // Gradient
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black38],
                      ),
                    ),
                  ),
                  // Back + share
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 8,
                    left: 12,
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: _NavButton(icon: Icons.arrow_back_rounded),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 8,
                    right: 12,
                    child: FavoriteButton(
                      id: profileId,
                      type: FavoriteType.business,
                    ),
                  ),
                ],
              ),
            ),
            // Circular logo overlapping
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
                      : const Icon(Icons.store_rounded,
                          size: 40, color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
        // Name + description
        const SizedBox(height: 56),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.3,
                ),
                textAlign: TextAlign.center,
              ),
              if (description != null) ...[
                const SizedBox(height: 8),
                Text(
                  description!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;

  const _NavButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
          ),
        ],
      ),
      child: Icon(icon, size: 20, color: const Color(0xFF1E293B)),
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

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
            ),
          ],
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
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

