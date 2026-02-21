// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantLocationImpl _$$RestaurantLocationImplFromJson(
  Map<String, dynamic> json,
) => _$RestaurantLocationImpl(
  id: (json['id'] as num).toInt(),
  restaurantId: (json['restaurantId'] as num?)?.toInt(),
  latitude: json['latitude'] as String?,
  longitude: json['longitude'] as String?,
  address: json['address'] as String?,
);

Map<String, dynamic> _$$RestaurantLocationImplToJson(
  _$RestaurantLocationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'restaurantId': instance.restaurantId,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'address': instance.address,
};
