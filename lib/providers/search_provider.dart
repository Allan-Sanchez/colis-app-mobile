import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart';
import '../models/directory_profile.dart';
import 'dio_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<
    ({List<Restaurant> restaurants, List<DirectoryProfile> profiles})>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.trim().isEmpty) {
    return (restaurants: <Restaurant>[], profiles: <DirectoryProfile>[]);
  }
  final repo = ref.read(searchRepositoryProvider);
  return repo.search(query);
});
