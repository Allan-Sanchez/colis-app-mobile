// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_social.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantSocialImpl _$$RestaurantSocialImplFromJson(
  Map<String, dynamic> json,
) => _$RestaurantSocialImpl(
  id: (json['id'] as num).toInt(),
  restaurantId: (json['restaurantId'] as num?)?.toInt(),
  platform: json['platform'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$$RestaurantSocialImplToJson(
  _$RestaurantSocialImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'restaurantId': instance.restaurantId,
  'platform': instance.platform,
  'url': instance.url,
};
