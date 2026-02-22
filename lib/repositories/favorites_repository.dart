import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepository {
  static const _restaurantsKey = 'favorite_restaurants';
  static const _businessesKey = 'favorite_businesses';

  final SharedPreferences _prefs;

  FavoritesRepository(this._prefs);

  // --- Restaurants ---

  Set<int> getRestaurantIds() {
    final raw = _prefs.getString(_restaurantsKey) ?? '';
    if (raw.isEmpty) return {};
    return raw.split(',').map((e) => int.tryParse(e)).whereType<int>().toSet();
  }

  Future<void> toggleRestaurant(int id) async {
    final ids = getRestaurantIds();
    if (ids.contains(id)) {
      ids.remove(id);
    } else {
      ids.add(id);
    }
    await _prefs.setString(_restaurantsKey, ids.join(','));
  }

  bool isRestaurantFavorite(int id) => getRestaurantIds().contains(id);

  // --- Businesses (directory profiles) ---

  Set<int> getBusinessIds() {
    final raw = _prefs.getString(_businessesKey) ?? '';
    if (raw.isEmpty) return {};
    return raw.split(',').map((e) => int.tryParse(e)).whereType<int>().toSet();
  }

  Future<void> toggleBusiness(int id) async {
    final ids = getBusinessIds();
    if (ids.contains(id)) {
      ids.remove(id);
    } else {
      ids.add(id);
    }
    await _prefs.setString(_businessesKey, ids.join(','));
  }

  bool isBusinessFavorite(int id) => getBusinessIds().contains(id);
}
