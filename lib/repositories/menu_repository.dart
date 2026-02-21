import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../core/network/api_response.dart';
import '../models/menu.dart';
import '../models/menu_category.dart';
import '../models/menu_item.dart';

class MenuRepository {
  final Dio _dio;

  MenuRepository(this._dio);

  Future<ApiResponse<List<Menu>>> getMenus() async {
    final response = await _dio.get(ApiConstants.menus);
    return ApiResponse.fromJson(
      response.data,
      (json) => (json as List).map((e) => Menu.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<List<MenuCategory>>> getMenuCategories() async {
    final response = await _dio.get(ApiConstants.menuCategories);
    return ApiResponse.fromJson(
      response.data,
      (json) =>
          (json as List).map((e) => MenuCategory.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<List<MenuItem>>> getMenuItems() async {
    final response = await _dio.get(ApiConstants.menuItems);
    return ApiResponse.fromJson(
      response.data,
      (json) => (json as List).map((e) => MenuItem.fromJson(e)).toList(),
    );
  }
}
