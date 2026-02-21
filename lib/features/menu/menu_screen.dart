import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/menu_provider.dart';
import '../../models/menu_category.dart';
import 'widgets/menu_category_tabs.dart';
import 'widgets/menu_item_card.dart';

class MenuScreen extends ConsumerStatefulWidget {
  final int restaurantId;

  const MenuScreen({super.key, required this.restaurantId});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final menuAsync = ref.watch(menuByRestaurantProvider(widget.restaurantId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: menuAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              const Text('Error al cargar menu'),
            ],
          ),
        ),
        data: (menu) {
          if (menu == null) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book, size: 64, color: AppColors.textSecondary),
                  SizedBox(height: 16),
                  Text(
                    'Este restaurante aun no tiene menu',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          final categoriesAsync =
              ref.watch(categoriesByMenuProvider(menu.id));

          return categoriesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) =>
                const Center(child: Text('Error al cargar categorias')),
            data: (categories) {
              if (categories.isEmpty) {
                return const Center(
                  child: Text('No hay categorias en el menu'),
                );
              }

              return Column(
                children: [
                  const SizedBox(height: 12),
                  MenuCategoryTabs(
                    categories: categories,
                    selectedIndex: _selectedCategoryIndex,
                    onSelected: (index) =>
                        setState(() => _selectedCategoryIndex = index),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _MenuItemsList(
                      category: categories[_selectedCategoryIndex],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _MenuItemsList extends ConsumerWidget {
  final MenuCategory category;

  const _MenuItemsList({required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemsByCategoryProvider(category.id));

    return itemsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Error al cargar items')),
      data: (items) {
        if (items.isEmpty) {
          return const Center(
            child: Text(
              'No hay items en esta categoria',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return MenuItemCard(item: items[index]);
          },
        );
      },
    );
  }
}
