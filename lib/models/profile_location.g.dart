// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileLocationImpl _$$ProfileLocationImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileLocationImpl(
  id: (json['id'] as num).toInt(),
  profileId: (json['profileId'] as num?)?.toInt(),
  latitude: json['latitude'] as String?,
  longitude: json['longitude'] as String?,
  address: json['address'] as String?,
);

Map<String, dynamic> _$$ProfileLocationImplToJson(
  _$ProfileLocationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'profileId': instance.profileId,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'address': instance.address,
};
