import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../core/network/api_response.dart';
import '../models/restaurant.dart';
import '../models/directory_profile.dart';

class SearchRepository {
  final Dio _dio;

  SearchRepository(this._dio);

  Future<({List<Restaurant> restaurants, List<DirectoryProfile> profiles})>
      search(String query) async {
    final results = await Future.wait([
      _dio.get(ApiConstants.restaurants),
      _dio.get(ApiConstants.directoryProfiles),
    ]);

    final restaurantsResponse = ApiResponse.fromJson(
      results[0].data,
      (json) => (json as List).map((e) => Restaurant.fromJson(e)).toList(),
    );

    final profilesResponse = ApiResponse.fromJson(
      results[1].data,
      (json) =>
          (json as List).map((e) => DirectoryProfile.fromJson(e)).toList(),
    );

    final queryLower = query.toLowerCase();

    final filteredRestaurants = (restaurantsResponse.data ?? [])
        .where((r) => r.name.toLowerCase().contains(queryLower))
        .toList();

    final filteredProfiles = (profilesResponse.data ?? [])
        .where((p) => p.name.toLowerCase().contains(queryLower))
        .toList();

    return (restaurants: filteredRestaurants, profiles: filteredProfiles);
  }
}
