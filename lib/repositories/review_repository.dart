import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../models/review.dart';

class ReviewRepository {
  final Dio _dio;

  ReviewRepository(this._dio);

  Future<List<Review>> getReviews({
    required String entityType,
    required int entityId,
  }) async {
    final response = await _dio.get(
      '${ApiConstants.reviews}/$entityType/$entityId',
    );
    final data = response.data['data'] as List<dynamic>? ?? [];
    return data.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Review> createReview({
    required String entityType,
    required int entityId,
    required int rating,
    String? comment,
    required String deviceId,
  }) async {
    final response = await _dio.post(
      ApiConstants.reviews,
      data: {
        'entityType': entityType,
        'entityId': entityId,
        'rating': rating,
        if (comment != null && comment.isNotEmpty) 'comment': comment,
        'deviceId': deviceId,
      },
    );
    return Review.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}
