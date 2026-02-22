import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/directory_provider.dart';
import 'widgets/category_card.dart';

class DirectoryScreen extends ConsumerWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(directoryCategoriesProvider);
    final profilesAsync = ref.watch(directoryProfilesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background.withValues(alpha: 0.95),
        elevation: 0,
        title: const Text(
          'Directorio',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: categoriesAsync.when(
        loading: () => const _DirectoryShimmer(),
        error: (_, __) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_rounded,
                  size: 56,
                  color: AppColors.textSecondary.withValues(alpha: 0.4)),
              const SizedBox(height: 16),
              const Text('Error al cargar categorías',
                  style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.invalidate(directoryCategoriesProvider),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (categories) {
          if (categories.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.store_mall_directory_rounded,
                      size: 72,
                      color: AppColors.textSecondary.withValues(alpha: 0.3)),
                  const SizedBox(height: 20),
                  const Text(
                    'No hay categorías disponibles',
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
            onRefresh: () async {
              ref.invalidate(directoryCategoriesProvider);
              ref.invalidate(directoryProfilesProvider);
            },
            child: AnimationLimiter(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final count = profilesAsync.whenOrNull(
                        data: (profiles) => profiles
                            .where((p) => p.categoryId == category.id)
                            .length,
                      ) ??
                      0;

                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: 2,
                    child: SlideAnimation(
                      verticalOffset: 24.0,
                      child: FadeInAnimation(
                        child: CategoryCard(
                          category: category,
                          profileCount: count,
                          onTap: () => context.push(
                            '/directory/category/${category.id}',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DirectoryShimmer extends StatelessWidget {
  const _DirectoryShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[50]!,
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemCount: 6,
        itemBuilder: (_, __) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
