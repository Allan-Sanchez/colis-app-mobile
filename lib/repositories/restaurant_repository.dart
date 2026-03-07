import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../core/network/api_response.dart';
import '../models/restaurant.dart';
import '../models/restaurant_location.dart';
import '../models/restaurant_social.dart';

class RestaurantRepository {
  final Dio _dio;

  RestaurantRepository(this._dio);

  Future<ApiResponse<List<Restaurant>>> getRestaurants() async {
    final response = await _dio.get(ApiConstants.restaurants);
    return ApiResponse.fromJson(
      response.data,
      (json) => (json as List).map((e) => Restaurant.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<List<Restaurant>>> getFeaturedRestaurants({int limit = 10}) async {
    final response = await _dio.get(
      ApiConstants.restaurants,
      queryParameters: {'featured': 'true', 'limit': limit},
    );
    return ApiResponse.fromJson(
      response.data,
      (json) => (json as List).map((e) => Restaurant.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<Restaurant>> getRestaurantById(int id) async {
    final response = await _dio.get('${ApiConstants.restaurants}/$id');
    return ApiResponse.fromJson(
      response.data,
      (json) => Restaurant.fromJson(json),
    );
  }

  Future<ApiResponse<List<RestaurantLocation>>> getRestaurantLocations() async {
    final response = await _dio.get(ApiConstants.restaurantLocations);
    return ApiResponse.fromJson(
      response.data,
      (json) =>
          (json as List).map((e) => RestaurantLocation.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<List<RestaurantSocial>>> getRestaurantSocials() async {
    final response = await _dio.get(ApiConstants.restaurantSocials);
    return ApiResponse.fromJson(
      response.data,
      (json) =>
          (json as List).map((e) => RestaurantSocial.fromJson(e)).toList(),
    );
  }
}
