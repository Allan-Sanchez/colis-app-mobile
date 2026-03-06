// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  return _Restaurant.fromJson(json);
}

/// @nodoc
mixin _$Restaurant {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get planTier => throw _privateConstructorUsedError;
  int get planPriority => throw _privateConstructorUsedError;
  String? get planStartDate => throw _privateConstructorUsedError;
  String? get planEndDate => throw _privateConstructorUsedError;
  String? get planNotes => throw _privateConstructorUsedError;
  String? get openingHours => throw _privateConstructorUsedError;
  bool get hasDelivery => throw _privateConstructorUsedError;
  bool get hasDineIn => throw _privateConstructorUsedError;
  bool get hasTakeout => throw _privateConstructorUsedError;
  String? get priceRange => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Restaurant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantCopyWith<Restaurant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantCopyWith<$Res> {
  factory $RestaurantCopyWith(
    Restaurant value,
    $Res Function(Restaurant) then,
  ) = _$RestaurantCopyWithImpl<$Res, Restaurant>;
  @useResult
  $Res call({
    int id,
    String name,
    String? imageUrl,
    String? description,
    String planTier,
    int planPriority,
    String? planStartDate,
    String? planEndDate,
    String? planNotes,
    String? openingHours,
    bool hasDelivery,
    bool hasDineIn,
    bool hasTakeout,
    String? priceRange,
    List<String>? tags,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class _$RestaurantCopyWithImpl<$Res, $Val extends Restaurant>
    implements $RestaurantCopyWith<$Res> {
  _$RestaurantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = freezed,
    Object? description = freezed,
    Object? planTier = null,
    Object? planPriority = null,
    Object? planStartDate = freezed,
    Object? planEndDate = freezed,
    Object? planNotes = freezed,
    Object? openingHours = freezed,
    Object? hasDelivery = null,
    Object? hasDineIn = null,
    Object? hasTakeout = null,
    Object? priceRange = freezed,
    Object? tags = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            planTier: null == planTier
                ? _value.planTier
                : planTier // ignore: cast_nullable_to_non_nullable
                      as String,
            planPriority: null == planPriority
                ? _value.planPriority
                : planPriority // ignore: cast_nullable_to_non_nullable
                      as int,
            planStartDate: freezed == planStartDate
                ? _value.planStartDate
                : planStartDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            planEndDate: freezed == planEndDate
                ? _value.planEndDate
                : planEndDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            planNotes: freezed == planNotes
                ? _value.planNotes
                : planNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            openingHours: freezed == openingHours
                ? _value.openingHours
                : openingHours // ignore: cast_nullable_to_non_nullable
                      as String?,
            hasDelivery: null == hasDelivery
                ? _value.hasDelivery
                : hasDelivery // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasDineIn: null == hasDineIn
                ? _value.hasDineIn
                : hasDineIn // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasTakeout: null == hasTakeout
                ? _value.hasTakeout
                : hasTakeout // ignore: cast_nullable_to_non_nullable
                      as bool,
            priceRange: freezed == priceRange
                ? _value.priceRange
                : priceRange // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RestaurantImplCopyWith<$Res>
    implements $RestaurantCopyWith<$Res> {
  factory _$$RestaurantImplCopyWith(
    _$RestaurantImpl value,
    $Res Function(_$RestaurantImpl) then,
  ) = __$$RestaurantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? imageUrl,
    String? description,
    String planTier,
    int planPriority,
    String? planStartDate,
    String? planEndDate,
    String? planNotes,
    String? openingHours,
    bool hasDelivery,
    bool hasDineIn,
    bool hasTakeout,
    String? priceRange,
    List<String>? tags,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class __$$RestaurantImplCopyWithImpl<$Res>
    extends _$RestaurantCopyWithImpl<$Res, _$RestaurantImpl>
    implements _$$RestaurantImplCopyWith<$Res> {
  __$$RestaurantImplCopyWithImpl(
    _$RestaurantImpl _value,
    $Res Function(_$RestaurantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = freezed,
    Object? description = freezed,
    Object? planTier = null,
    Object? planPriority = null,
    Object? planStartDate = freezed,
    Object? planEndDate = freezed,
    Object? planNotes = freezed,
    Object? openingHours = freezed,
    Object? hasDelivery = null,
    Object? hasDineIn = null,
    Object? hasTakeout = null,
    Object? priceRange = freezed,
    Object? tags = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$RestaurantImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        planTier: null == planTier
            ? _value.planTier
            : planTier // ignore: cast_nullable_to_non_nullable
                  as String,
        planPriority: null == planPriority
            ? _value.planPriority
            : planPriority // ignore: cast_nullable_to_non_nullable
                  as int,
        planStartDate: freezed == planStartDate
            ? _value.planStartDate
            : planStartDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        planEndDate: freezed == planEndDate
            ? _value.planEndDate
            : planEndDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        planNotes: freezed == planNotes
            ? _value.planNotes
            : planNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        openingHours: freezed == openingHours
            ? _value.openingHours
            : openingHours // ignore: cast_nullable_to_non_nullable
                  as String?,
        hasDelivery: null == hasDelivery
            ? _value.hasDelivery
            : hasDelivery // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasDineIn: null == hasDineIn
            ? _value.hasDineIn
            : hasDineIn // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasTakeout: null == hasTakeout
            ? _value.hasTakeout
            : hasTakeout // ignore: cast_nullable_to_non_nullable
                  as bool,
        priceRange: freezed == priceRange
            ? _value.priceRange
            : priceRange // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: freezed == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RestaurantImpl implements _Restaurant {
  const _$RestaurantImpl({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
    this.planTier = 'free',
    this.planPriority = 1,
    this.planStartDate,
    this.planEndDate,
    this.planNotes,
    this.openingHours,
    this.hasDelivery = false,
    this.hasDineIn = true,
    this.hasTakeout = false,
    this.priceRange,
    final List<String>? tags,
    this.createdAt,
    this.updatedAt,
  }) : _tags = tags;

  factory _$RestaurantImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestaurantImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? imageUrl;
  @override
  final String? description;
  @override
  @JsonKey()
  final String planTier;
  @override
  @JsonKey()
  final int planPriority;
  @override
  final String? planStartDate;
  @override
  final String? planEndDate;
  @override
  final String? planNotes;
  @override
  final String? openingHours;
  @override
  @JsonKey()
  final bool hasDelivery;
  @override
  @JsonKey()
  final bool hasDineIn;
  @override
  @JsonKey()
  final bool hasTakeout;
  @override
  final String? priceRange;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'Restaurant(id: $id, name: $name, imageUrl: $imageUrl, description: $description, planTier: $planTier, planPriority: $planPriority, planStartDate: $planStartDate, planEndDate: $planEndDate, planNotes: $planNotes, openingHours: $openingHours, hasDelivery: $hasDelivery, hasDineIn: $hasDineIn, hasTakeout: $hasTakeout, priceRange: $priceRange, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.planTier, planTier) ||
                other.planTier == planTier) &&
            (identical(other.planPriority, planPriority) ||
                other.planPriority == planPriority) &&
            (identical(other.planStartDate, planStartDate) ||
                other.planStartDate == planStartDate) &&
            (identical(other.planEndDate, planEndDate) ||
                other.planEndDate == planEndDate) &&
            (identical(other.planNotes, planNotes) ||
                other.planNotes == planNotes) &&
            (identical(other.openingHours, openingHours) ||
                other.openingHours == openingHours) &&
            (identical(other.hasDelivery, hasDelivery) ||
                other.hasDelivery == hasDelivery) &&
            (identical(other.hasDineIn, hasDineIn) ||
                other.hasDineIn == hasDineIn) &&
            (identical(other.hasTakeout, hasTakeout) ||
                other.hasTakeout == hasTakeout) &&
            (identical(other.priceRange, priceRange) ||
                other.priceRange == priceRange) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    imageUrl,
    description,
    planTier,
    planPriority,
    planStartDate,
    planEndDate,
    planNotes,
    openingHours,
    hasDelivery,
    hasDineIn,
    hasTakeout,
    priceRange,
    const DeepCollectionEquality().hash(_tags),
    createdAt,
    updatedAt,
  );

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantImplCopyWith<_$RestaurantImpl> get copyWith =>
      __$$RestaurantImplCopyWithImpl<_$RestaurantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantImplToJson(this);
  }
}

abstract class _Restaurant implements Restaurant {
  const factory _Restaurant({
    required final int id,
    required final String name,
    final String? imageUrl,
    final String? description,
    final String planTier,
    final int planPriority,
    final String? planStartDate,
    final String? planEndDate,
    final String? planNotes,
    final String? openingHours,
    final bool hasDelivery,
    final bool hasDineIn,
    final bool hasTakeout,
    final String? priceRange,
    final List<String>? tags,
    final String? createdAt,
    final String? updatedAt,
  }) = _$RestaurantImpl;

  factory _Restaurant.fromJson(Map<String, dynamic> json) =
      _$RestaurantImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get imageUrl;
  @override
  String? get description;
  @override
  String get planTier;
  @override
  int get planPriority;
  @override
  String? get planStartDate;
  @override
  String? get planEndDate;
  @override
  String? get planNotes;
  @override
  String? get openingHours;
  @override
  bool get hasDelivery;
  @override
  bool get hasDineIn;
  @override
  bool get hasTakeout;
  @override
  String? get priceRange;
  @override
  List<String>? get tags;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantImplCopyWith<_$RestaurantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
