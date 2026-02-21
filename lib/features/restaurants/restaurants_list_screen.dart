import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/restaurant_provider.dart';
import 'widgets/restaurant_card.dart';
import 'widgets/filter_chips.dart';

class RestaurantsListScreen extends ConsumerStatefulWidget {
  const RestaurantsListScreen({super.key});

  @override
  ConsumerState<RestaurantsListScreen> createState() =>
      _RestaurantsListScreenState();
}

class _RestaurantsListScreenState
    extends ConsumerState<RestaurantsListScreen> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final restaurantsAsync = ref.watch(restaurantsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Restaurantes'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          FilterChips(
            selectedIndex: _selectedFilter,
            onSelected: (index) => setState(() => _selectedFilter = index),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: restaurantsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48,
                        color: AppColors.error),
                    const SizedBox(height: 16),
                    const Text('Error al cargar restaurantes'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () =>
                          ref.invalidate(restaurantsProvider),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
              data: (restaurants) {
                var filtered = restaurants;
                if (_selectedFilter == 1) {
                  filtered = restaurants
                      .where((r) => r.isFeatured)
                      .toList();
                }

                if (filtered.isEmpty) {
                  return const Center(
                    child: Text(
                      AppStrings.noResults,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(restaurantsProvider);
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return RestaurantCard(restaurant: filtered[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
