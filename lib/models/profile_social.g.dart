// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_social.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileSocialImpl _$$ProfileSocialImplFromJson(Map<String, dynamic> json) =>
    _$ProfileSocialImpl(
      id: (json['id'] as num).toInt(),
      profileId: (json['profileId'] as num?)?.toInt(),
      platform: json['platform'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$ProfileSocialImplToJson(_$ProfileSocialImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profileId': instance.profileId,
      'platform': instance.platform,
      'url': instance.url,
    };
