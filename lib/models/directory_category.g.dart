// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directory_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DirectoryCategoryImpl _$$DirectoryCategoryImplFromJson(
  Map<String, dynamic> json,
) => _$DirectoryCategoryImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$$DirectoryCategoryImplToJson(
  _$DirectoryCategoryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'imageUrl': instance.imageUrl,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
