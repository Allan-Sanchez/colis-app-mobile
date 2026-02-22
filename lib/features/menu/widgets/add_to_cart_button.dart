import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/menu_item.dart';
import '../../../providers/cart_provider.dart';

class AddToCartButton extends ConsumerWidget {
  final MenuItem item;
  final int restaurantId;

  const AddToCartButton({
    super.key,
    required this.item,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartItem = cartState.items.where((ci) => ci.item.id == item.id).firstOrNull;
    final inCart = cartItem != null;

    if (inCart) {
      // Quantity selector
      return Container(
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _QuantityButton(
              icon: Icons.remove_rounded,
              onTap: () => ref
                  .read(cartProvider.notifier)
                  .updateQuantity(item.id, cartItem.quantity - 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${cartItem.quantity}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
            _QuantityButton(
              icon: Icons.add_rounded,
              onTap: () => ref
                  .read(cartProvider.notifier)
                  .addItem(item, restaurantId),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () async {
        final conflict =
            ref.read(cartProvider.notifier).addItem(item, restaurantId);
        if (conflict) {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('¿Iniciar nuevo pedido?'),
              content: const Text(
                'Ya tienes productos de otro restaurante en tu carrito. '
                'Si continúas, perderás esos productos.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Nuevo pedido'),
                ),
              ],
            ),
          );
          if (confirm == true) {
            ref
                .read(cartProvider.notifier)
                .replaceCartAndAdd(item, restaurantId);
          }
        }
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 30,
        height: 32,
        child: Icon(icon, size: 16, color: AppColors.primary),
      ),
    );
  }
}
