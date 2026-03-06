// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directory_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DirectoryProfileImpl _$$DirectoryProfileImplFromJson(
  Map<String, dynamic> json,
) => _$DirectoryProfileImpl(
  id: (json['id'] as num).toInt(),
  categoryId: (json['categoryId'] as num?)?.toInt(),
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String?,
  description: json['description'] as String?,
  planTier: json['planTier'] as String? ?? 'free',
  planPriority: (json['planPriority'] as num?)?.toInt() ?? 1,
  planStartDate: json['planStartDate'] as String?,
  planEndDate: json['planEndDate'] as String?,
  planNotes: json['planNotes'] as String?,
  openingHours: json['openingHours'] as String?,
  ownerName: json['ownerName'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  acceptedPayments: (json['acceptedPayments'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$$DirectoryProfileImplToJson(
  _$DirectoryProfileImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'categoryId': instance.categoryId,
  'name': instance.name,
  'imageUrl': instance.imageUrl,
  'description': instance.description,
  'planTier': instance.planTier,
  'planPriority': instance.planPriority,
  'planStartDate': instance.planStartDate,
  'planEndDate': instance.planEndDate,
  'planNotes': instance.planNotes,
  'openingHours': instance.openingHours,
  'ownerName': instance.ownerName,
  'tags': instance.tags,
  'acceptedPayments': instance.acceptedPayments,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
