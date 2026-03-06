import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../core/network/api_response.dart';

class PlanRequestRepository {
  final Dio _dio;

  PlanRequestRepository(this._dio);

  Future<ApiResponse<Map<String, dynamic>>> createPlanRequest({
    required String entityType,
    required int entityId,
    required String entityName,
    required String desiredTier,
    required String contactName,
    required String contactPhone,
  }) async {
    final body = {
      'entityType': entityType,
      'entityId': entityId,
      'entityName': entityName,
      'desiredTier': desiredTier,
      'contactName': contactName,
      'contactPhone': contactPhone,
    };
    final response = await _dio.post(ApiConstants.planRequests, data: body);
    return ApiResponse.fromJson(
      response.data,
      (json) => json as Map<String, dynamic>,
    );
  }
}
