import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/directory_provider.dart';
import 'widgets/business_card.dart';

class CategoryBusinessesScreen extends ConsumerWidget {
  final int categoryId;

  const CategoryBusinessesScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(directoryCategoriesProvider);
    final businessesAsync = ref.watch(profilesByCategoryProvider(categoryId));

    final categoryName = categoriesAsync.whenOrNull(
          data: (cats) =>
              cats.where((c) => c.id == categoryId).firstOrNull?.name,
        ) ??
        'Categoría';

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
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        title: Text(
          categoryName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: businessesAsync.when(
        loading: () => const _BusinessesShimmer(),
        error: (_, __) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: 56,
                color: AppColors.textSecondary.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 16),
              const Text(
                'Error al cargar negocios',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.invalidate(directoryProfilesProvider),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (businesses) {
          if (businesses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.store_rounded,
                    size: 72,
                    color: AppColors.textSecondary.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No hay negocios en esta categoría',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async => ref.invalidate(directoryProfilesProvider),
            child: AnimationLimiter(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                itemCount: businesses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 24.0,
                    child: FadeInAnimation(
                      child: BusinessCard(business: businesses[index]),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BusinessesShimmer extends StatelessWidget {
  const _BusinessesShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[50]!,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
