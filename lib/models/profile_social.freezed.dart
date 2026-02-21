// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_social.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProfileSocial _$ProfileSocialFromJson(Map<String, dynamic> json) {
  return _ProfileSocial.fromJson(json);
}

/// @nodoc
mixin _$ProfileSocial {
  int get id => throw _privateConstructorUsedError;
  int? get profileId => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this ProfileSocial to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileSocial
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileSocialCopyWith<ProfileSocial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileSocialCopyWith<$Res> {
  factory $ProfileSocialCopyWith(
    ProfileSocial value,
    $Res Function(ProfileSocial) then,
  ) = _$ProfileSocialCopyWithImpl<$Res, ProfileSocial>;
  @useResult
  $Res call({int id, int? profileId, String platform, String url});
}

/// @nodoc
class _$ProfileSocialCopyWithImpl<$Res, $Val extends ProfileSocial>
    implements $ProfileSocialCopyWith<$Res> {
  _$ProfileSocialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileSocial
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = freezed,
    Object? platform = null,
    Object? url = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            profileId: freezed == profileId
                ? _value.profileId
                : profileId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ProfileSocialImplCopyWith<$Res>
    implements $ProfileSocialCopyWith<$Res> {
  factory _$$ProfileSocialImplCopyWith(
    _$ProfileSocialImpl value,
    $Res Function(_$ProfileSocialImpl) then,
  ) = __$$ProfileSocialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int? profileId, String platform, String url});
}

/// @nodoc
class __$$ProfileSocialImplCopyWithImpl<$Res>
    extends _$ProfileSocialCopyWithImpl<$Res, _$ProfileSocialImpl>
    implements _$$ProfileSocialImplCopyWith<$Res> {
  __$$ProfileSocialImplCopyWithImpl(
    _$ProfileSocialImpl _value,
    $Res Function(_$ProfileSocialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileSocial
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = freezed,
    Object? platform = null,
    Object? url = null,
  }) {
    return _then(
      _$ProfileSocialImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        profileId: freezed == profileId
            ? _value.profileId
            : profileId // ignore: cast_nullable_to_non_nullable
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
class _$ProfileSocialImpl implements _ProfileSocial {
  const _$ProfileSocialImpl({
    required this.id,
    this.profileId,
    required this.platform,
    required this.url,
  });

  factory _$ProfileSocialImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileSocialImplFromJson(json);

  @override
  final int id;
  @override
  final int? profileId;
  @override
  final String platform;
  @override
  final String url;

  @override
  String toString() {
    return 'ProfileSocial(id: $id, profileId: $profileId, platform: $platform, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileSocialImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, profileId, platform, url);

  /// Create a copy of ProfileSocial
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileSocialImplCopyWith<_$ProfileSocialImpl> get copyWith =>
      __$$ProfileSocialImplCopyWithImpl<_$ProfileSocialImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileSocialImplToJson(this);
  }
}

abstract class _ProfileSocial implements ProfileSocial {
  const factory _ProfileSocial({
    required final int id,
    final int? profileId,
    required final String platform,
    required final String url,
  }) = _$ProfileSocialImpl;

  factory _ProfileSocial.fromJson(Map<String, dynamic> json) =
      _$ProfileSocialImpl.fromJson;

  @override
  int get id;
  @override
  int? get profileId;
  @override
  String get platform;
  @override
  String get url;

  /// Create a copy of ProfileSocial
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileSocialImplCopyWith<_$ProfileSocialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
