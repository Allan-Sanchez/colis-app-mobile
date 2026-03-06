import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant.freezed.dart';
part 'restaurant.g.dart';

@freezed
class Restaurant with _$Restaurant {
  const factory Restaurant({
    required int id,
    required String name,
    String? imageUrl,
    String? description,
    @Default('free') String planTier,
    @Default(1) int planPriority,
    String? planStartDate,
    String? planEndDate,
    String? planNotes,
    String? openingHours,
    @Default(false) bool hasDelivery,
    @Default(true) bool hasDineIn,
    @Default(false) bool hasTakeout,
    String? priceRange,
    List<String>? tags,
    String? createdAt,
    String? updatedAt,
  }) = _Restaurant;

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);
}
