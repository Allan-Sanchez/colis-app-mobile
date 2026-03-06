import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart';
import '../models/directory_category.dart';
import '../models/directory_profile.dart';
import 'restaurant_provider.dart';
import 'directory_provider.dart';

class HomeData {
  final List<Restaurant> featuredRestaurants;
  final List<DirectoryCategory> categories;
  final List<DirectoryProfile> featuredBusinesses;

  HomeData({
    required this.featuredRestaurants,
    required this.categories,
    required this.featuredBusinesses,
  });
}

final homeDataProvider = FutureProvider<HomeData>((ref) async {
  final restaurants = await ref.watch(restaurantsProvider.future);
  final categories = await ref.watch(directoryCategoriesProvider.future);
  final profiles = await ref.watch(directoryProfilesProvider.future);

  return HomeData(
    featuredRestaurants: restaurants.where((r) => r.planTier == 'standard' || r.planTier == 'premium').toList(),
    categories: categories,
    featuredBusinesses: profiles.where((p) => p.planTier == 'standard' || p.planTier == 'premium').toList(),
  );
});
