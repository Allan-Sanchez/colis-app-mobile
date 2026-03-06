import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dio_provider.dart';
import '../core/constants/api_constants.dart';

/// Obtiene todas las configuraciones del servidor y las expone como Map<String, String>.
/// Los datos del "About" se almacenan con claves: about_creator_name, about_whatsapp, about_email
final appConfigProvider = FutureProvider<Map<String, String>>((ref) async {
  final dio = ref.read(dioClientProvider).dio;
  final response = await dio.get(ApiConstants.config);

  // El endpoint devuelve ApiResponse con data: List<{key: string, value: string}>
  final data = response.data;
  final List<dynamic> items;

  if (data is Map && data['data'] != null) {
    items = data['data'] as List<dynamic>;
  } else if (data is List) {
    items = data;
  } else {
    return {};
  }

  return Map.fromEntries(
    items.map((item) {
      final map = item as Map<String, dynamic>;
      return MapEntry(
        map['key'] as String? ?? '',
        map['value'] as String? ?? '',
      );
    }).where((e) => e.key.isNotEmpty),
  );
});
