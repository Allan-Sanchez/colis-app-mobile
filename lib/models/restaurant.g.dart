// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantImpl _$$RestaurantImplFromJson(Map<String, dynamic> json) =>
    _$RestaurantImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      planTier: json['planTier'] as String? ?? 'free',
      planPriority: (json['planPriority'] as num?)?.toInt() ?? 1,
      planStartDate: json['planStartDate'] as String?,
      planEndDate: json['planEndDate'] as String?,
      planNotes: json['planNotes'] as String?,
      openingHours: json['openingHours'] as String?,
      hasDelivery: json['hasDelivery'] as bool? ?? false,
      hasDineIn: json['hasDineIn'] as bool? ?? true,
      hasTakeout: json['hasTakeout'] as bool? ?? false,
      priceRange: json['priceRange'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$RestaurantImplToJson(_$RestaurantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'planTier': instance.planTier,
      'planPriority': instance.planPriority,
      'planStartDate': instance.planStartDate,
      'planEndDate': instance.planEndDate,
      'planNotes': instance.planNotes,
      'openingHours': instance.openingHours,
      'hasDelivery': instance.hasDelivery,
      'hasDineIn': instance.hasDineIn,
      'hasTakeout': instance.hasTakeout,
      'priceRange': instance.priceRange,
      'tags': instance.tags,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
