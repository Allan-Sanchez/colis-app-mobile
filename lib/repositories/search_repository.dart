import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../core/network/api_response.dart';
import '../models/restaurant.dart';
import '../models/directory_profile.dart';

/// Normaliza un texto: minúsculas + sin tildes/diacríticos.
/// Permite buscar "cafe" y encontrar "Café", o "futbol" → "Fútbol".
String _normalize(String input) {
  const accented =    'áàäâãéèëêíìïîóòöôõúùüûñçÁÀÄÂÃÉÈËÊÍÌÏÎÓÒÖÔÕÚÙÜÛÑÇ';
  const unaccented = 'aaaaaeeeeiiiioooooouuuuncaaaaaeeeeiiiioooooouuuunc';
  final lower = input.toLowerCase();
  return lower.split('').map((ch) {
    final idx = accented.indexOf(ch);
    return idx != -1 ? unaccented[idx] : ch;
  }).join();
}

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

    final queryNorm = _normalize(query);

    final filteredRestaurants = (restaurantsResponse.data ?? [])
        .where((r) =>
            _normalize(r.name).contains(queryNorm) ||
            (r.description != null &&
                _normalize(r.description!).contains(queryNorm)))
        .toList();

    final filteredProfiles = (profilesResponse.data ?? [])
        .where((p) =>
            _normalize(p.name).contains(queryNorm) ||
            (p.description != null &&
                _normalize(p.description!).contains(queryNorm)))
        .toList();

    return (restaurants: filteredRestaurants, profiles: filteredProfiles);
  }
}
