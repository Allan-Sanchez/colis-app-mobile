import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/directory_category.dart';
import '../../shared/widgets/pressable.dart';

class CategoryCard extends StatelessWidget {
  final DirectoryCategory category;
  final int profileCount;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.profileCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: category.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: category.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const Icon(
                          Icons.category,
                          color: AppColors.primary,
                          size: 28,
                        ),
                        errorWidget: (_, __, ___) => const Icon(
                          Icons.category,
                          color: AppColors.primary,
                          size: 28,
                        ),
                      ),
                    )
                  : const Icon(
                      Icons.category,
                      color: AppColors.primary,
                      size: 28,
                    ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                category.name,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$profileCount negocios',
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
