// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileContactImpl _$$ProfileContactImplFromJson(Map<String, dynamic> json) =>
    _$ProfileContactImpl(
      id: (json['id'] as num).toInt(),
      profileId: (json['profileId'] as num?)?.toInt(),
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$ProfileContactImplToJson(
  _$ProfileContactImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'profileId': instance.profileId,
  'phoneNumber': instance.phoneNumber,
  'email': instance.email,
};
