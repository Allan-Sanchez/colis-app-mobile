// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'directory_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DirectoryProfile _$DirectoryProfileFromJson(Map<String, dynamic> json) {
  return _DirectoryProfile.fromJson(json);
}

/// @nodoc
mixin _$DirectoryProfile {
  int get id => throw _privateConstructorUsedError;
  int? get categoryId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DirectoryProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DirectoryProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DirectoryProfileCopyWith<DirectoryProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectoryProfileCopyWith<$Res> {
  factory $DirectoryProfileCopyWith(
    DirectoryProfile value,
    $Res Function(DirectoryProfile) then,
  ) = _$DirectoryProfileCopyWithImpl<$Res, DirectoryProfile>;
  @useResult
  $Res call({
    int id,
    int? categoryId,
    String name,
    String? imageUrl,
    String? description,
    bool isFeatured,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class _$DirectoryProfileCopyWithImpl<$Res, $Val extends DirectoryProfile>
    implements $DirectoryProfileCopyWith<$Res> {
  _$DirectoryProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DirectoryProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryId = freezed,
    Object? name = null,
    Object? imageUrl = freezed,
    Object? description = freezed,
    Object? isFeatured = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int?,
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
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$DirectoryProfileImplCopyWith<$Res>
    implements $DirectoryProfileCopyWith<$Res> {
  factory _$$DirectoryProfileImplCopyWith(
    _$DirectoryProfileImpl value,
    $Res Function(_$DirectoryProfileImpl) then,
  ) = __$$DirectoryProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int? categoryId,
    String name,
    String? imageUrl,
    String? description,
    bool isFeatured,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class __$$DirectoryProfileImplCopyWithImpl<$Res>
    extends _$DirectoryProfileCopyWithImpl<$Res, _$DirectoryProfileImpl>
    implements _$$DirectoryProfileImplCopyWith<$Res> {
  __$$DirectoryProfileImplCopyWithImpl(
    _$DirectoryProfileImpl _value,
    $Res Function(_$DirectoryProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DirectoryProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryId = freezed,
    Object? name = null,
    Object? imageUrl = freezed,
    Object? description = freezed,
    Object? isFeatured = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$DirectoryProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int?,
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
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$DirectoryProfileImpl implements _DirectoryProfile {
  const _$DirectoryProfileImpl({
    required this.id,
    this.categoryId,
    required this.name,
    this.imageUrl,
    this.description,
    this.isFeatured = false,
    this.createdAt,
    this.updatedAt,
  });

  factory _$DirectoryProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectoryProfileImplFromJson(json);

  @override
  final int id;
  @override
  final int? categoryId;
  @override
  final String name;
  @override
  final String? imageUrl;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isFeatured;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'DirectoryProfile(id: $id, categoryId: $categoryId, name: $name, imageUrl: $imageUrl, description: $description, isFeatured: $isFeatured, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectoryProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
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
    categoryId,
    name,
    imageUrl,
    description,
    isFeatured,
    createdAt,
    updatedAt,
  );

  /// Create a copy of DirectoryProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectoryProfileImplCopyWith<_$DirectoryProfileImpl> get copyWith =>
      __$$DirectoryProfileImplCopyWithImpl<_$DirectoryProfileImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DirectoryProfileImplToJson(this);
  }
}

abstract class _DirectoryProfile implements DirectoryProfile {
  const factory _DirectoryProfile({
    required final int id,
    final int? categoryId,
    required final String name,
    final String? imageUrl,
    final String? description,
    final bool isFeatured,
    final String? createdAt,
    final String? updatedAt,
  }) = _$DirectoryProfileImpl;

  factory _DirectoryProfile.fromJson(Map<String, dynamic> json) =
      _$DirectoryProfileImpl.fromJson;

  @override
  int get id;
  @override
  int? get categoryId;
  @override
  String get name;
  @override
  String? get imageUrl;
  @override
  String? get description;
  @override
  bool get isFeatured;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;

  /// Create a copy of DirectoryProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DirectoryProfileImplCopyWith<_$DirectoryProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
