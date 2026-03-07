import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';

class AnalyticsRepository {
  final Dio _dio;

  AnalyticsRepository(this._dio);

  /// Fire and forget — no retorna resultado, ignora errores silenciosamente.
  Future<void> track({
    required String entityType,
    required int entityId,
    required String eventType,
  }) async {
    try {
      await _dio.post(
        '${ApiConstants.apiPrefix}/analytics/events',
        data: {
          'entityType': entityType,
          'entityId': entityId,
          'eventType': eventType,
        },
      );
    } catch (_) {
      // Analytics son best-effort: ignorar errores de red
    }
  }
}
