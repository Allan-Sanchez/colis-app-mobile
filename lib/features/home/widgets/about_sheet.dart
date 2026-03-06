import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';
import '../../../providers/config_provider.dart';

class AboutSheet extends ConsumerWidget {
  const AboutSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(appConfigProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 24),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Logo
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.storefront_rounded, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text(
            'Colis',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const Text(
            'Versión 1.0.0',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          // Creado por
          configAsync.when(
            loading: () => const _CreatorShimmer(),
            error: (_, __) => const _CreatorFallback(),
            data: (config) => Column(
              children: [
                const Text(
                  'Creado por',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary, letterSpacing: 0.5),
                ),
                const SizedBox(height: 4),
                Text(
                  config['about_creator_name'] ?? 'Allan Sanchez',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          // Publicidad
          const Text(
            '¿Quieres anunciarte?',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Contáctanos y lleva tu negocio a más clientes en Colis',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          configAsync.when(
            loading: () => const SizedBox(height: 96),
            error: (_, __) => const _ContactButtons(
              whatsapp: '+50252909724',
              email: 'asanchezrixtun@gmail.com',
            ),
            data: (config) => _ContactButtons(
              whatsapp: config['about_whatsapp'] ?? '+50252909724',
              email: config['about_email'] ?? 'asanchezrixtun@gmail.com',
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactButtons extends StatelessWidget {
  final String whatsapp;
  final String email;
  const _ContactButtons({required this.whatsapp, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // WhatsApp button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              final clean = whatsapp.replaceAll(RegExp(r'[^\d]'), '');
              launchUrl(
                Uri.parse('https://wa.me/$clean'),
                mode: LaunchMode.externalApplication,
              );
            },
            icon: const Icon(Icons.chat_rounded, size: 18),
            label: const Text('Contactar por WhatsApp'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25D366),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Email button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              launchUrl(
                Uri.parse('mailto:$email'),
                mode: LaunchMode.externalApplication,
              );
            },
            icon: const Icon(Icons.email_outlined, size: 18),
            label: Text('Enviar correo a $email'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              side: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}

class _CreatorShimmer extends StatelessWidget {
  const _CreatorShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 130,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }
}

class _CreatorFallback extends StatelessWidget {
  const _CreatorFallback();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Creado por',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        SizedBox(height: 4),
        Text(
          'Allan Sanchez',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
