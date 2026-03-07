import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/review.dart';
import '../../../providers/dio_provider.dart';
import '../../../providers/favorites_provider.dart'; // sharedPreferencesProvider
import '../../../providers/review_provider.dart';

class ReviewsSection extends ConsumerStatefulWidget {
  final String entityType;
  final int entityId;

  const ReviewsSection({
    super.key,
    required this.entityType,
    required this.entityId,
  });

  @override
  ConsumerState<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends ConsumerState<ReviewsSection> {
  bool _alreadyReviewed = false;

  String get _prefKey => 'reviewed_${widget.entityType}_${widget.entityId}';

  @override
  void initState() {
    super.initState();
    final prefs = ref.read(sharedPreferencesProvider);
    _alreadyReviewed = prefs.getBool(_prefKey) ?? false;
  }

  Future<void> _showReviewSheet() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ReviewSheet(
        entityType: widget.entityType,
        entityId: widget.entityId,
        deviceId: ref.read(deviceIdProvider),
        onSubmitted: () async {
          final prefs = ref.read(sharedPreferencesProvider);
          await prefs.setBool(_prefKey, true);
          setState(() => _alreadyReviewed = true);
          ref.invalidate(reviewsProvider((
            entityType: widget.entityType,
            entityId: widget.entityId,
          )));
        },
      ),
    );
    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reseña guardada. ¡Gracias!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviewKey = (entityType: widget.entityType, entityId: widget.entityId);
    final reviewsAsync = ref.watch(reviewsProvider(reviewKey));

    return reviewsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (reviews) {
        final avgRating = reviews.isEmpty
            ? 0.0
            : reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Row(
              children: [
                const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 22),
                const SizedBox(width: 6),
                Text(
                  'Reseñas',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                if (reviews.isNotEmpty)
                  Row(
                    children: [
                      Text(
                        avgRating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF59E0B),
                        ),
                      ),
                      const SizedBox(width: 4),
                      _StarDisplay(rating: avgRating, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '(${reviews.length})',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Lista de reseñas
            if (reviews.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Sé el primero en dejar una reseña',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                ),
              )
            else
              ...reviews.take(5).map((r) => _ReviewCard(review: r)),

            const SizedBox(height: 12),

            // Botón dejar reseña
            if (_alreadyReviewed)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF86EFAC)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Ya dejaste tu reseña',
                      style: TextStyle(
                        color: Color(0xFF16A34A),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _showReviewSheet,
                  icon: const Icon(Icons.star_border_rounded, size: 18),
                  label: const Text('Dejar reseña'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Review review;
  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _StarDisplay(rating: review.rating.toDouble(), size: 14),
              const Spacer(),
              Text(
                _formatDate(review.createdAt),
                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
            ],
          ),
          if (review.comment != null && review.comment!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              review.comment!,
              style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return '';
    }
  }
}

class _StarDisplay extends StatelessWidget {
  final double rating;
  final double size;
  const _StarDisplay({required this.rating, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < rating.round();
        return Icon(
          filled ? Icons.star_rounded : Icons.star_border_rounded,
          color: const Color(0xFFF59E0B),
          size: size,
        );
      }),
    );
  }
}

// ---- Review submission bottom sheet ----

class _ReviewSheet extends ConsumerStatefulWidget {
  final String entityType;
  final int entityId;
  final String deviceId;
  final Future<void> Function() onSubmitted;

  const _ReviewSheet({
    required this.entityType,
    required this.entityId,
    required this.deviceId,
    required this.onSubmitted,
  });

  @override
  ConsumerState<_ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends ConsumerState<_ReviewSheet> {
  int _rating = 0;
  final _commentController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_rating == 0) {
      setState(() => _error = 'Selecciona una calificación');
      return;
    }
    setState(() { _loading = true; _error = null; });
    try {
      await ref.read(reviewRepositoryProvider).createReview(
            entityType: widget.entityType,
            entityId: widget.entityId,
            rating: _rating,
            comment: _commentController.text.trim(),
            deviceId: widget.deviceId,
          );
      await widget.onSubmitted();
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      final msg = e.toString().contains('409') || e.toString().contains('ALREADY_REVIEWED')
          ? 'Ya dejaste una reseña para este negocio'
          : 'Error al guardar. Intenta de nuevo.';
      setState(() => _error = msg);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deja tu reseña',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tu opinión ayuda a otros usuarios',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),

          // Star picker
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              final selected = i < _rating;
              return GestureDetector(
                onTap: () => setState(() => _rating = i + 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    selected ? Icons.star_rounded : Icons.star_border_rounded,
                    color: const Color(0xFFF59E0B),
                    size: 40,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),

          // Comment
          TextField(
            controller: _commentController,
            maxLines: 3,
            maxLength: 300,
            decoration: InputDecoration(
              hintText: 'Cuéntanos tu experiencia (opcional)',
              hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),

          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 13)),
          ],

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _loading ? null : _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: _loading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Publicar reseña', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
