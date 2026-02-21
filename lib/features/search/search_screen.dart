import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/search_provider.dart';
import 'widgets/search_result_section.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(searchQueryProvider.notifier).state = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchResultsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Buscar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              autofocus: true,
              decoration: InputDecoration(
                hintText: AppStrings.searchHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          ref.read(searchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: searchResults.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (error, _) => const Center(
                child: Text('Error al buscar'),
              ),
              data: (results) {
                final query = ref.watch(searchQueryProvider);
                if (query.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 64,
                            color: AppColors.textSecondary),
                        SizedBox(height: 16),
                        Text(
                          'Busca restaurantes y negocios',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final hasResults = results.restaurants.isNotEmpty ||
                    results.profiles.isNotEmpty;

                if (!hasResults) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off, size: 64,
                            color: AppColors.textSecondary),
                        const SizedBox(height: 16),
                        Text(
                          '${AppStrings.noResults} para "$query"',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SearchResultSection(
                        title: 'Restaurantes',
                        count: results.restaurants.length,
                        children: results.restaurants.map((restaurant) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 4),
                            child: ListTile(
                              onTap: () => context
                                  .push('/restaurants/${restaurant.id}'),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: restaurant.imageUrl != null
                                      ? CachedNetworkImage(
                                          imageUrl: restaurant.imageUrl!,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          color: AppColors.background,
                                          child: const Icon(
                                              Icons.restaurant,
                                              color:
                                                  AppColors.textSecondary),
                                        ),
                                ),
                              ),
                              title: Text(restaurant.name),
                              subtitle: restaurant.description != null
                                  ? Text(
                                      restaurant.description!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : null,
                              trailing: const Icon(Icons.chevron_right),
                              tileColor: AppColors.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side:
                                    const BorderSide(color: AppColors.border),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      SearchResultSection(
                        title: 'Negocios',
                        count: results.profiles.length,
                        children: results.profiles.map((profile) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 4),
                            child: ListTile(
                              onTap: () => context.push(
                                  '/directory/business/${profile.id}'),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: profile.imageUrl != null
                                      ? CachedNetworkImage(
                                          imageUrl: profile.imageUrl!,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          color: AppColors.background,
                                          child: const Icon(Icons.store,
                                              color:
                                                  AppColors.textSecondary),
                                        ),
                                ),
                              ),
                              title: Text(profile.name),
                              subtitle: profile.description != null
                                  ? Text(
                                      profile.description!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : null,
                              trailing: const Icon(Icons.chevron_right),
                              tileColor: AppColors.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side:
                                    const BorderSide(color: AppColors.border),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                    ],
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
