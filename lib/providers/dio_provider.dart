import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/dio_client.dart';
import '../repositories/restaurant_repository.dart';
import '../repositories/directory_repository.dart';
import '../repositories/menu_repository.dart';
import '../repositories/search_repository.dart';
import '../repositories/order_repository.dart';
import '../repositories/plan_request_repository.dart';
import '../repositories/analytics_repository.dart';
import '../repositories/review_repository.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  return RestaurantRepository(ref.read(dioClientProvider).dio);
});

final directoryRepositoryProvider = Provider<DirectoryRepository>((ref) {
  return DirectoryRepository(ref.read(dioClientProvider).dio);
});

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  return MenuRepository(ref.read(dioClientProvider).dio);
});

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepository(ref.read(dioClientProvider).dio);
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(ref.read(dioClientProvider).dio);
});

final planRequestRepositoryProvider = Provider<PlanRequestRepository>((ref) {
  return PlanRequestRepository(ref.read(dioClientProvider).dio);
});

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  return AnalyticsRepository(ref.read(dioClientProvider).dio);
});

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository(ref.read(dioClientProvider).dio);
});
