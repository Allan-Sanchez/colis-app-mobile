import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart';
import '../models/restaurant_location.dart';
import '../models/restaurant_social.dart';
import 'dio_provider.dart';

final restaurantsProvider = FutureProvider<List<Restaurant>>((ref) async {
  final repo = ref.read(restaurantRepositoryProvider);
  final response = await repo.getRestaurants();
  return response.data ?? [];
});

final featuredRestaurantsProvider = Provider<AsyncValue<List<Restaurant>>>((ref) {
  return ref.watch(restaurantsProvider).whenData(
        (restaurants) => restaurants.where((r) => r.planTier == 'standard' || r.planTier == 'premium').toList(),
      );
});

final restaurantByIdProvider =
    FutureProvider.family<Restaurant?, int>((ref, id) async {
  final repo = ref.read(restaurantRepositoryProvider);
  final response = await repo.getRestaurantById(id);
  return response.data;
});

final restaurantLocationsProvider =
    FutureProvider<List<RestaurantLocation>>((ref) async {
  final repo = ref.read(restaurantRepositoryProvider);
  final response = await repo.getRestaurantLocations();
  return response.data ?? [];
});

final restaurantSocialsProvider =
    FutureProvider<List<RestaurantSocial>>((ref) async {
  final repo = ref.read(restaurantRepositoryProvider);
  final response = await repo.getRestaurantSocials();
  return response.data ?? [];
});

final restaurantLocationsByIdProvider =
    Provider.family<AsyncValue<List<RestaurantLocation>>, int>((ref, restaurantId) {
  return ref.watch(restaurantLocationsProvider).whenData(
        (locations) =>
            locations.where((l) => l.restaurantId == restaurantId).toList(),
      );
});

final restaurantSocialsByIdProvider =
    Provider.family<AsyncValue<List<RestaurantSocial>>, int>((ref, restaurantId) {
  return ref.watch(restaurantSocialsProvider).whenData(
        (socials) =>
            socials.where((s) => s.restaurantId == restaurantId).toList(),
      );
});
