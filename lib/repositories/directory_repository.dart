import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../core/network/api_response.dart';
import '../models/directory_category.dart';
import '../models/directory_profile.dart';
import '../models/profile_contact.dart';
import '../models/profile_location.dart';
import '../models/profile_social.dart';

class DirectoryRepository {
  final Dio _dio;

  DirectoryRepository(this._dio);

  Future<ApiResponse<List<DirectoryCategory>>> getCategories() async {
    final response = await _dio.get(ApiConstants.directoryCategories);
    return ApiResponse.fromJson(
      response.data,
      (json) =>
          (json as List).map((e) => DirectoryCategory.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<List<DirectoryProfile>>> getProfiles() async {
    final response = await _dio.get(ApiConstants.directoryProfiles);
    return ApiResponse.fromJson(
      response.data,
      (json) =>
          (json as List).map((e) => DirectoryProfile.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<DirectoryProfile>> getProfileById(int id) async {
    final response = await _dio.get('${ApiConstants.directoryProfiles}/$id');
    return ApiResponse.fromJson(
      response.data,
      (json) => DirectoryProfile.fromJson(json),
    );
  }

  Future<ApiResponse<List<ProfileContact>>> getProfileContacts() async {
    final response = await _dio.get(ApiConstants.profileContacts);
    return ApiResponse.fromJson(
      response.data,
      (json) =>
          (json as List).map((e) => ProfileContact.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<List<ProfileLocation>>> getProfileLocations() async {
    final response = await _dio.get(ApiConstants.profileLocations);
    return ApiResponse.fromJson(
      response.data,
      (json) =>
          (json as List).map((e) => ProfileLocation.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<List<ProfileSocial>>> getProfileSocials() async {
    final response = await _dio.get(ApiConstants.profileSocials);
    return ApiResponse.fromJson(
      response.data,
      (json) =>
          (json as List).map((e) => ProfileSocial.fromJson(e)).toList(),
    );
  }
}
