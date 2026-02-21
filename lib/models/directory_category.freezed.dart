// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'directory_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DirectoryCategory _$DirectoryCategoryFromJson(Map<String, dynamic> json) {
  return _DirectoryCategory.fromJson(json);
}

/// @nodoc
mixin _$DirectoryCategory {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DirectoryCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DirectoryCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DirectoryCategoryCopyWith<DirectoryCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectoryCategoryCopyWith<$Res> {
  factory $DirectoryCategoryCopyWith(
    DirectoryCategory value,
    $Res Function(DirectoryCategory) then,
  ) = _$DirectoryCategoryCopyWithImpl<$Res, DirectoryCategory>;
  @useResult
  $Res call({
    int id,
    String name,
    String? imageUrl,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class _$DirectoryCategoryCopyWithImpl<$Res, $Val extends DirectoryCategory>
    implements $DirectoryCategoryCopyWith<$Res> {
  _$DirectoryCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DirectoryCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = freezed,
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
abstract class _$$DirectoryCategoryImplCopyWith<$Res>
    implements $DirectoryCategoryCopyWith<$Res> {
  factory _$$DirectoryCategoryImplCopyWith(
    _$DirectoryCategoryImpl value,
    $Res Function(_$DirectoryCategoryImpl) then,
  ) = __$$DirectoryCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? imageUrl,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class __$$DirectoryCategoryImplCopyWithImpl<$Res>
    extends _$DirectoryCategoryCopyWithImpl<$Res, _$DirectoryCategoryImpl>
    implements _$$DirectoryCategoryImplCopyWith<$Res> {
  __$$DirectoryCategoryImplCopyWithImpl(
    _$DirectoryCategoryImpl _value,
    $Res Function(_$DirectoryCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DirectoryCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$DirectoryCategoryImpl(
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
class _$DirectoryCategoryImpl implements _DirectoryCategory {
  const _$DirectoryCategoryImpl({
    required this.id,
    required this.name,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory _$DirectoryCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectoryCategoryImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? imageUrl;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'DirectoryCategory(id: $id, name: $name, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectoryCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, imageUrl, createdAt, updatedAt);

  /// Create a copy of DirectoryCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectoryCategoryImplCopyWith<_$DirectoryCategoryImpl> get copyWith =>
      __$$DirectoryCategoryImplCopyWithImpl<_$DirectoryCategoryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DirectoryCategoryImplToJson(this);
  }
}

abstract class _DirectoryCategory implements DirectoryCategory {
  const factory _DirectoryCategory({
    required final int id,
    required final String name,
    final String? imageUrl,
    final String? createdAt,
    final String? updatedAt,
  }) = _$DirectoryCategoryImpl;

  factory _DirectoryCategory.fromJson(Map<String, dynamic> json) =
      _$DirectoryCategoryImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get imageUrl;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;

  /// Create a copy of DirectoryCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DirectoryCategoryImplCopyWith<_$DirectoryCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
