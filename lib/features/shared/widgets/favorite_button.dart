import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/favorites_provider.dart';

enum FavoriteType { restaurant, business }

class FavoriteButton extends ConsumerStatefulWidget {
  final int id;
  final FavoriteType type;
  final bool showBackground;

  const FavoriteButton({
    super.key,
    required this.id,
    required this.type,
    this.showBackground = true,
  });

  @override
  ConsumerState<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends ConsumerState<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    // Scale goes 1.0 → 1.35 with easeOut, then 1.35 → 1.0 with elasticOut
    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.35)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.35, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 65,
      ),
    ]).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  ProviderListenable<bool> get _provider =>
      widget.type == FavoriteType.restaurant
          ? isRestaurantFavoriteProvider(widget.id)
          : isBusinessFavoriteProvider(widget.id);

  @override
  Widget build(BuildContext context) {
    final isFavorite = ref.watch(_provider);

    // Bounce when toggled ON
    ref.listen(_provider, (prev, next) {
      if (next == true && prev != true) {
        _ctrl.forward(from: 0.0);
      }
    });

    return GestureDetector(
      onTap: () {
        if (widget.type == FavoriteType.restaurant) {
          ref.read(favoritesProvider.notifier).toggleRestaurant(widget.id);
        } else {
          ref.read(favoritesProvider.notifier).toggleBusiness(widget.id);
        }
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: widget.showBackground
            ? BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 8,
                  ),
                ],
              )
            : null,
        child: ScaleTransition(
          scale: _scale,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              key: ValueKey(isFavorite),
              color: isFavorite ? Colors.red : const Color(0xFF64748B),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
