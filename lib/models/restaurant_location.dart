import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_location.freezed.dart';
part 'restaurant_location.g.dart';

@freezed
class RestaurantLocation with _$RestaurantLocation {
  const factory RestaurantLocation({
    required int id,
    int? restaurantId,
    String? latitude,
    String? longitude,
    String? address,
  }) = _RestaurantLocation;

  factory RestaurantLocation.fromJson(Map<String, dynamic> json) =>
      _$RestaurantLocationFromJson(json);
}
