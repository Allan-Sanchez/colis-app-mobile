import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/menu_provider.dart';
import '../../providers/restaurant_provider.dart';
import '../../models/menu_category.dart';
import 'widgets/menu_item_card.dart';
import '../shared/widgets/cart_fab.dart';

String _normalize(String input) {
  const accented =    'áàäâãéèëêíìïîóòöôõúùüûñçÁÀÄÂÃÉÈËÊÍÌÏÎÓÒÖÔÕÚÙÜÛÑÇ';
  const unaccented = 'aaaaaeeeeiiiioooooouuuuncaaaaaeeeeiiiioooooouuuunc';
  final lower = input.toLowerCase();
  return lower.split('').map((ch) {
    final idx = accented.indexOf(ch);
    return idx != -1 ? unaccented[idx] : ch;
  }).join();
}

class MenuScreen extends ConsumerStatefulWidget {
  final int restaurantId;

  const MenuScreen({super.key, required this.restaurantId});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  int _selectedCategoryIndex = 0;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantAsync =
        ref.watch(restaurantByIdProvider(widget.restaurantId));
    final menuAsync =
        ref.watch(menuByRestaurantProvider(widget.restaurantId));

    final restaurantName = restaurantAsync.whenOrNull(
          data: (r) => r?.name ?? 'Menú',
        ) ??
        'Menú';

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const CartFab(),
      body: menuAsync.when(
        loading: () => const _MenuShimmer(),
        error: (_, __) => const Center(child: Text('Error al cargar menú')),
        data: (menu) {
          if (menu == null) {
            return _EmptyMenu(restaurantName: restaurantName);
          }

          final categoriesAsync =
              ref.watch(categoriesByMenuProvider(menu.id));

          return categoriesAsync.when(
            loading: () => const _MenuShimmer(),
            error: (_, __) =>
                const Center(child: Text('Error al cargar categorías')),
            data: (categories) {
              if (categories.isEmpty) {
                return _EmptyMenu(restaurantName: restaurantName);
              }

              return NestedScrollView(
                headerSliverBuilder: (context, innerScrolled) => [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.white.withValues(alpha: 0.95),
                    surfaceTintColor: Colors.transparent,
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
                    title: Column(
                      children: [
                        Text(
                          restaurantName,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Text(
                          'MENÚ',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: _MenuSearchDelegate(
                              categories: categories,
                              ref: ref,
                              restaurantId: widget.restaurantId,
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.search_rounded,
                              size: 18, color: AppColors.textPrimary),
                        ),
                      ),
                    ],
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(52),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                        ),
                        child: _CategoryTabBar(
                          categories: categories,
                          selectedIndex: _selectedCategoryIndex,
                          onSelected: (i) =>
                              setState(() => _selectedCategoryIndex = i),
                        ),
                      ),
                    ),
                  ),
                ],
                body: _MenuItemsList(
                  category: categories[_selectedCategoryIndex],
                  searchQuery: _searchQuery,
                  restaurantId: widget.restaurantId,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _CategoryTabBar extends StatelessWidget {
  final List<MenuCategory> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _CategoryTabBar({
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : null,
                border: isSelected
                    ? null
                    : Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Text(
                categories[index].name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MenuItemsList extends ConsumerWidget {
  final MenuCategory category;
  final String searchQuery;
  final int restaurantId;

  const _MenuItemsList({
    required this.category,
    required this.searchQuery,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemsByCategoryProvider(category.id));

    return itemsAsync.when(
      loading: () => const _MenuShimmer(),
      error: (_, __) => const Center(child: Text('Error al cargar items')),
      data: (items) {
        var filtered = items;
        if (searchQuery.isNotEmpty) {
          final queryNorm = _normalize(searchQuery);
          filtered = items
              .where((i) => _normalize(i.title).contains(queryNorm))
              .toList();
        }

        if (filtered.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.fastfood_rounded,
                    size: 56,
                    color: AppColors.textSecondary.withValues(alpha: 0.4)),
                const SizedBox(height: 16),
                const Text(
                  'Sin items en esta categoría',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 22,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: MenuItemCard(item: filtered[index], restaurantId: restaurantId),
                ),
                childCount: filtered.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        );
      },
    );
  }
}

class _EmptyMenu extends StatelessWidget {
  final String restaurantName;

  const _EmptyMenu({required this.restaurantName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurantName)),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book_rounded,
                size: 72, color: AppColors.textSecondary),
            SizedBox(height: 20),
            Text(
              'Este restaurante aún no tiene menú',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuSearchDelegate extends SearchDelegate<String> {
  final List<MenuCategory> categories;
  final WidgetRef ref;
  final int restaurantId;

  _MenuSearchDelegate({required this.categories, required this.ref, required this.restaurantId});

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back), onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) => _buildSearchBody(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchBody(context);

  Widget _buildSearchBody(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Escribe para buscar platillos',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: categories.map((category) {
        final itemsAsync = ref.read(itemsByCategoryProvider(category.id));
        return itemsAsync.whenOrNull(
              data: (items) {
                final queryNorm = _normalize(query);
                final filtered = items
                    .where((i) => _normalize(i.title).contains(queryNorm))
                    .toList();
                if (filtered.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: filtered
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: MenuItemCard(item: item, restaurantId: restaurantId),
                          ))
                      .toList(),
                );
              },
            ) ??
            const SizedBox.shrink();
      }).toList(),
    );
  }
}

class _MenuShimmer extends StatelessWidget {
  const _MenuShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[50]!,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
