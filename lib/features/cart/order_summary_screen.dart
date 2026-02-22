import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/cart_provider.dart';
import '../../providers/restaurant_provider.dart';
import '../../providers/dio_provider.dart';

class OrderSummaryScreen extends ConsumerStatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  ConsumerState<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends ConsumerState<OrderSummaryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _confirmOrder() async {
    if (!_formKey.currentState!.validate()) return;

    final cartState = ref.read(cartProvider);
    if (cartState.restaurantId == null) return;

    setState(() => _isLoading = true);

    try {
      // 1. Guardar orden en el backend
      final repo = ref.read(orderRepositoryProvider);
      final response = await repo.createOrder(
        restaurantId: cartState.restaurantId!,
        customerName: _nameController.text.trim(),
        customerPhone: _phoneController.text.trim(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        items: cartState.items,
      );

      if (!mounted) return;

      final orderId = response.data?.id;

      // 2. Obtener número de WhatsApp del restaurante
      final socialsAsync = ref.read(
        restaurantSocialsByIdProvider(cartState.restaurantId!),
      );
      final whatsappNumber = socialsAsync.whenOrNull(
        data: (socials) {
          final wa = socials.where(
            (s) => s.platform.toLowerCase() == 'whatsapp',
          );
          return wa.isEmpty ? null : wa.first.url;
        },
      );

      // 3. Construir mensaje
      final message = _buildWhatsAppMessage(
        cartState: cartState,
        customerName: _nameController.text.trim(),
        customerPhone: _phoneController.text.trim(),
        notes: _notesController.text.trim(),
        orderId: orderId,
      );

      // 4. Abrir WhatsApp
      if (whatsappNumber != null) {
        final cleanNumber = whatsappNumber.replaceAll(RegExp(r'[^0-9+]'), '');
        final encoded = Uri.encodeComponent(message);
        final uri = Uri.parse('https://wa.me/$cleanNumber?text=$encoded');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      } else {
        // Sin WhatsApp — solo mostrar confirmación
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pedido guardado. El restaurante no tiene WhatsApp configurado.'),
          ),
        );
      }

      // 5. Limpiar carrito y navegar a confirmación
      ref.read(cartProvider.notifier).clear();
      if (!mounted) return;
      context.go('/order/${orderId ?? 0}/confirmation');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al procesar el pedido: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _buildWhatsAppMessage({
    required CartState cartState,
    required String customerName,
    required String customerPhone,
    required String notes,
    int? orderId,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('¡Hola! Quiero hacer el siguiente pedido:');
    buffer.writeln();

    for (final ci in cartState.items) {
      final price = double.tryParse(ci.item.price ?? '0') ?? 0;
      buffer.writeln('• ${ci.quantity}x ${ci.item.title}  \$${price.toStringAsFixed(2)} c/u');
    }

    buffer.writeln();
    buffer.writeln('💰 *Total: \$${cartState.totalFormatted}*');
    buffer.writeln();
    buffer.writeln('👤 Nombre: $customerName');
    buffer.writeln('📱 Teléfono: $customerPhone');

    if (notes.isNotEmpty) {
      buffer.writeln('📝 Notas: $notes');
    }

    if (orderId != null) {
      buffer.writeln();
      buffer.writeln('🔖 Pedido #$orderId');
    }

    return buffer.toString().trim();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 18, color: AppColors.textPrimary),
          ),
        ),
        title: const Text(
          'Resumen del Pedido',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Resumen de items ──────────────────────────────────────
              _SectionLabel(label: 'Tu pedido (${cartState.totalCount} items)'),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ...cartState.items.map((ci) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${ci.quantity}x ${ci.item.title}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              Text(
                                '\$${ci.subtotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        )),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '\$${cartState.totalFormatted}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // ── Datos del cliente ──────────────────────────────────────
              _SectionLabel(label: 'Tus datos'),
              const SizedBox(height: 10),
              _InputField(
                controller: _nameController,
                label: 'Nombre',
                hint: 'Tu nombre completo',
                icon: Icons.person_rounded,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 12),
              _InputField(
                controller: _phoneController,
                label: 'Teléfono',
                hint: '+52 555 123 4567',
                icon: Icons.phone_rounded,
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 12),
              _InputField(
                controller: _notesController,
                label: 'Notas (opcional)',
                hint: 'Sin cebolla, extra salsa...',
                icon: Icons.notes_rounded,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
            20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            onPressed: _isLoading ? null : _confirmOrder,
            icon: _isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.chat_rounded),
            label: Text(_isLoading ? 'Procesando...' : 'Confirmar y enviar por WhatsApp'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25D366),
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
