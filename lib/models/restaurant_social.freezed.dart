// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_social.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RestaurantSocial _$RestaurantSocialFromJson(Map<String, dynamic> json) {
  return _RestaurantSocial.fromJson(json);
}

/// @nodoc
mixin _$RestaurantSocial {
  int get id => throw _privateConstructorUsedError;
  int? get restaurantId => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this RestaurantSocial to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantSocial
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantSocialCopyWith<RestaurantSocial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantSocialCopyWith<$Res> {
  factory $RestaurantSocialCopyWith(
    RestaurantSocial value,
    $Res Function(RestaurantSocial) then,
  ) = _$RestaurantSocialCopyWithImpl<$Res, RestaurantSocial>;
  @useResult
  $Res call({int id, int? restaurantId, String platform, String url});
}

/// @nodoc
class _$RestaurantSocialCopyWithImpl<$Res, $Val extends RestaurantSocial>
    implements $RestaurantSocialCopyWith<$Res> {
  _$RestaurantSocialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantSocial
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = freezed,
    Object? platform = null,
    Object? url = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            restaurantId: freezed == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                      as int?,
            platform: null == platform
                ? _value.platform
                : platform // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RestaurantSocialImplCopyWith<$Res>
    implements $RestaurantSocialCopyWith<$Res> {
  factory _$$RestaurantSocialImplCopyWith(
    _$RestaurantSocialImpl value,
    $Res Function(_$RestaurantSocialImpl) then,
  ) = __$$RestaurantSocialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int? restaurantId, String platform, String url});
}

/// @nodoc
class __$$RestaurantSocialImplCopyWithImpl<$Res>
    extends _$RestaurantSocialCopyWithImpl<$Res, _$RestaurantSocialImpl>
    implements _$$RestaurantSocialImplCopyWith<$Res> {
  __$$RestaurantSocialImplCopyWithImpl(
    _$RestaurantSocialImpl _value,
    $Res Function(_$RestaurantSocialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantSocial
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = freezed,
    Object? platform = null,
    Object? url = null,
  }) {
    return _then(
      _$RestaurantSocialImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        restaurantId: freezed == restaurantId
            ? _value.restaurantId
            : restaurantId // ignore: cast_nullable_to_non_nullable
                  as int?,
        platform: null == platform
            ? _value.platform
            : platform // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RestaurantSocialImpl implements _RestaurantSocial {
  const _$RestaurantSocialImpl({
    required this.id,
    this.restaurantId,
    required this.platform,
    required this.url,
  });

  factory _$RestaurantSocialImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestaurantSocialImplFromJson(json);

  @override
  final int id;
  @override
  final int? restaurantId;
  @override
  final String platform;
  @override
  final String url;

  @override
  String toString() {
    return 'RestaurantSocial(id: $id, restaurantId: $restaurantId, platform: $platform, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantSocialImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, restaurantId, platform, url);

  /// Create a copy of RestaurantSocial
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantSocialImplCopyWith<_$RestaurantSocialImpl> get copyWith =>
      __$$RestaurantSocialImplCopyWithImpl<_$RestaurantSocialImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantSocialImplToJson(this);
  }
}

abstract class _RestaurantSocial implements RestaurantSocial {
  const factory _RestaurantSocial({
    required final int id,
    final int? restaurantId,
    required final String platform,
    required final String url,
  }) = _$RestaurantSocialImpl;

  factory _RestaurantSocial.fromJson(Map<String, dynamic> json) =
      _$RestaurantSocialImpl.fromJson;

  @override
  int get id;
  @override
  int? get restaurantId;
  @override
  String get platform;
  @override
  String get url;

  /// Create a copy of RestaurantSocial
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantSocialImplCopyWith<_$RestaurantSocialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
