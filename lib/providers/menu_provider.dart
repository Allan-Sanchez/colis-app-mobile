import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/menu.dart';
import '../models/menu_category.dart';
import '../models/menu_item.dart';
import 'dio_provider.dart';

final menusProvider = FutureProvider<List<Menu>>((ref) async {
  final repo = ref.read(menuRepositoryProvider);
  final response = await repo.getMenus();
  return response.data ?? [];
});

final menuCategoriesProvider =
    FutureProvider<List<MenuCategory>>((ref) async {
  final repo = ref.read(menuRepositoryProvider);
  final response = await repo.getMenuCategories();
  return response.data ?? [];
});

final menuItemsProvider = FutureProvider<List<MenuItem>>((ref) async {
  final repo = ref.read(menuRepositoryProvider);
  final response = await repo.getMenuItems();
  return response.data ?? [];
});

final menuByRestaurantProvider =
    Provider.family<AsyncValue<Menu?>, int>((ref, restaurantId) {
  return ref.watch(menusProvider).whenData(
        (menus) {
          final filtered = menus.where((m) => m.restaurantId == restaurantId);
          return filtered.isEmpty ? null : filtered.first;
        },
      );
});

final categoriesByMenuProvider =
    Provider.family<AsyncValue<List<MenuCategory>>, int>((ref, menuId) {
  return ref.watch(menuCategoriesProvider).whenData(
        (categories) =>
            categories.where((c) => c.menuId == menuId).toList(),
      );
});

final itemsByCategoryProvider =
    Provider.family<AsyncValue<List<MenuItem>>, int>((ref, categoryId) {
  return ref.watch(menuItemsProvider).whenData(
        (items) =>
            items.where((i) => i.categoryId == categoryId).toList(),
      );
});
