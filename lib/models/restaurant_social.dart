import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_social.freezed.dart';
part 'restaurant_social.g.dart';

@freezed
class RestaurantSocial with _$RestaurantSocial {
  const factory RestaurantSocial({
    required int id,
    int? restaurantId,
    required String platform,
    required String url,
  }) = _RestaurantSocial;

  factory RestaurantSocial.fromJson(Map<String, dynamic> json) =>
      _$RestaurantSocialFromJson(json);
}
