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
  isFeatured: json['isFeatured'] as bool? ?? false,
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
  'isFeatured': instance.isFeatured,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
