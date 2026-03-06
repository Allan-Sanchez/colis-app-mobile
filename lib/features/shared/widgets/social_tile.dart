import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';

class SocialTile extends StatelessWidget {
  final String platform;
  final String url;

  const SocialTile({super.key, required this.platform, required this.url});

  String get _platformName {
    switch (platform.toLowerCase()) {
      case 'facebook':
        return 'Facebook';
      case 'instagram':
        return 'Instagram';
      case 'whatsapp':
        return 'WhatsApp';
      case 'twitter':
      case 'x':
        return 'Twitter / X';
      case 'tiktok':
        return 'TikTok';
      case 'youtube':
        return 'YouTube';
      case 'website':
      case 'web':
        return 'Sitio web';
      default:
        return platform.isNotEmpty
            ? platform[0].toUpperCase() + platform.substring(1)
            : platform;
    }
  }

  String get _actionLabel {
    switch (platform.toLowerCase()) {
      case 'whatsapp':
        return 'Enviar mensaje';
      case 'website':
      case 'web':
        return 'Visitar sitio';
      default:
        return 'Ver perfil';
    }
  }

  IconData get _icon {
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
      case 'youtube':
        return Icons.play_circle_rounded;
      case 'website':
      case 'web':
        return Icons.language_rounded;
      default:
        return Icons.link_rounded;
    }
  }

  Color get _color {
    switch (platform.toLowerCase()) {
      case 'facebook':
        return const Color(0xFF1877F2);
      case 'instagram':
        return const Color(0xFFE1306C);
      case 'whatsapp':
        return const Color(0xFF25D366);
      case 'twitter':
      case 'x':
        return const Color(0xFF1DA1F2);
      case 'tiktok':
        return const Color(0xFF010101);
      case 'youtube':
        return const Color(0xFFFF0000);
      default:
        return AppColors.primary;
    }
  }

  Future<void> _launch() async {
    String rawUrl = url.trim();

    if (platform.toLowerCase() == 'whatsapp') {
      // Si es solo un número, construir URL wa.me
      if (!rawUrl.startsWith('http')) {
        final clean = rawUrl.replaceAll(RegExp(r'[^0-9+]'), '');
        rawUrl = 'https://wa.me/$clean';
      }
    } else if (!rawUrl.startsWith('http') &&
        !rawUrl.startsWith('tel:') &&
        !rawUrl.startsWith('mailto:')) {
      rawUrl = 'https://$rawUrl';
    }

    final uri = Uri.tryParse(rawUrl);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color;
    return GestureDetector(
      onTap: _launch,
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
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(_icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _actionLabel,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _platformName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: color.withValues(alpha: 0.6),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
