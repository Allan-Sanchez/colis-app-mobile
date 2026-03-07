import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/review.dart';
import '../providers/dio_provider.dart';
import '../providers/favorites_provider.dart'; // para sharedPreferencesProvider

typedef ReviewKey = ({String entityType, int entityId});

final reviewsProvider = FutureProvider.family<List<Review>, ReviewKey>((ref, key) {
  return ref.read(reviewRepositoryProvider).getReviews(
        entityType: key.entityType,
        entityId: key.entityId,
      );
});

/// Expone el deviceId leído sincrónicamente de SharedPreferences
final deviceIdProvider = Provider<String>((ref) {
  return ref.read(sharedPreferencesProvider).getString('device_id') ?? 'unknown';
});
