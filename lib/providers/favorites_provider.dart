import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/favorites_repository.dart';

// ─── SharedPreferences instance ───────────────────────────────────────────
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize with ProviderScope overrides');
});

// ─── Repository ───────────────────────────────────────────────────────────
final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return FavoritesRepository(prefs);
});

// ─── State ────────────────────────────────────────────────────────────────
class FavoritesState {
  final Set<int> restaurantIds;
  final Set<int> businessIds;

  const FavoritesState({
    required this.restaurantIds,
    required this.businessIds,
  });

  FavoritesState copyWith({Set<int>? restaurantIds, Set<int>? businessIds}) {
    return FavoritesState(
      restaurantIds: restaurantIds ?? this.restaurantIds,
      businessIds: businessIds ?? this.businessIds,
    );
  }
}

// ─── Notifier ─────────────────────────────────────────────────────────────
class FavoritesNotifier extends StateNotifier<FavoritesState> {
  final FavoritesRepository _repo;

  FavoritesNotifier(this._repo)
      : super(FavoritesState(
          restaurantIds: _repo.getRestaurantIds(),
          businessIds: _repo.getBusinessIds(),
        ));

  Future<void> toggleRestaurant(int id) async {
    await _repo.toggleRestaurant(id);
    state = state.copyWith(restaurantIds: _repo.getRestaurantIds());
  }

  Future<void> toggleBusiness(int id) async {
    await _repo.toggleBusiness(id);
    state = state.copyWith(businessIds: _repo.getBusinessIds());
  }

  bool isRestaurantFavorite(int id) => state.restaurantIds.contains(id);
  bool isBusinessFavorite(int id) => state.businessIds.contains(id);
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, FavoritesState>((ref) {
  final repo = ref.watch(favoritesRepositoryProvider);
  return FavoritesNotifier(repo);
});

// ─── Convenience selectors ────────────────────────────────────────────────
final isRestaurantFavoriteProvider = Provider.family<bool, int>((ref, id) {
  return ref.watch(favoritesProvider).restaurantIds.contains(id);
});

final isBusinessFavoriteProvider = Provider.family<bool, int>((ref, id) {
  return ref.watch(favoritesProvider).businessIds.contains(id);
});
