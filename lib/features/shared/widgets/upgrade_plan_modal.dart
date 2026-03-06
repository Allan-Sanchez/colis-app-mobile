import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../providers/dio_provider.dart';

class UpgradePlanModal extends ConsumerStatefulWidget {
  final int entityId;
  final String entityName;
  final String entityType; // 'restaurant' | 'directory_profile'
  final String currentPlanTier;

  const UpgradePlanModal({
    super.key,
    required this.entityId,
    required this.entityName,
    required this.entityType,
    required this.currentPlanTier,
  });

  @override
  ConsumerState<UpgradePlanModal> createState() => _UpgradePlanModalState();
}

class _UpgradePlanModalState extends ConsumerState<UpgradePlanModal> {
  String _selectedTier = 'standard';
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _loading = false;
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_nameController.text.trim().isEmpty || _phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      final repo = ref.read(planRequestRepositoryProvider);
      await repo.createPlanRequest(
        entityType: widget.entityType,
        entityId: widget.entityId,
        entityName: widget.entityName,
        desiredTier: _selectedTier,
        contactName: _nameController.text.trim(),
        contactPhone: _phoneController.text.trim(),
      );
      setState(() => _submitted = true);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al enviar solicitud. Intenta de nuevo.')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: _submitted ? _SuccessView(onClose: () => Navigator.of(context).pop()) : _FormView(
        selectedTier: _selectedTier,
        nameController: _nameController,
        phoneController: _phoneController,
        loading: _loading,
        entityName: widget.entityName,
        currentPlanTier: widget.currentPlanTier,
        onTierChanged: (tier) => setState(() => _selectedTier = tier),
        onSubmit: _submit,
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  final String selectedTier;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final bool loading;
  final String entityName;
  final String currentPlanTier;
  final ValueChanged<String> onTierChanged;
  final VoidCallback onSubmit;

  const _FormView({
    required this.selectedTier,
    required this.nameController,
    required this.phoneController,
    required this.loading,
    required this.entityName,
    required this.currentPlanTier,
    required this.onTierChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 24),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Mejorar Visibilidad',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close_rounded),
            ),
          ],
        ),
        Text(
          entityName,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 20),
        // Plan selector
        Row(
          children: [
            _PlanCard(
              tier: 'standard',
              label: 'Standard',
              price: 'Q150/mes',
              features: 'Destacado en inicio\nBadge azul',
              color: const Color(0xFF3B82F6),
              selected: selectedTier == 'standard',
              onTap: () => onTierChanged('standard'),
            ),
            const SizedBox(width: 12),
            _PlanCard(
              tier: 'premium',
              label: 'Premium',
              price: 'Q300/mes',
              features: 'Primero en listados\nBadge dorado',
              color: const Color(0xFFF59E0B),
              selected: selectedTier == 'premium',
              onTap: () => onTierChanged('premium'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Tu información de contacto',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: 'Nombre completo',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Teléfono (WhatsApp)',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: loading ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: loading
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Enviar solicitud', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Te contactaremos por WhatsApp para coordinar el pago',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String tier;
  final String label;
  final String price;
  final String features;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.tier,
    required this.label,
    required this.price,
    required this.features,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected ? color.withValues(alpha: 0.08) : Colors.white,
            border: Border.all(
              color: selected ? color : const Color(0xFFE2E8F0),
              width: selected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.star_rounded, color: color, size: 18),
                  const SizedBox(width: 6),
                  Text(label, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
                ],
              ),
              const SizedBox(height: 6),
              Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text(
                features,
                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  final VoidCallback onClose;

  const _SuccessView({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 36),
        ),
        const SizedBox(height: 16),
        const Text(
          'Solicitud enviada',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        const Text(
          'Te contactaremos por WhatsApp para coordinar el pago y activar tu plan.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onClose,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Cerrar', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

void showUpgradePlanModal(
  BuildContext context, {
  required int entityId,
  required String entityName,
  required String entityType,
  required String currentPlanTier,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => UpgradePlanModal(
      entityId: entityId,
      entityName: entityName,
      entityType: entityType,
      currentPlanTier: currentPlanTier,
    ),
  );
}
