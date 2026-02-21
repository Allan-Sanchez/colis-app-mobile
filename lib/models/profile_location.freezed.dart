// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProfileLocation _$ProfileLocationFromJson(Map<String, dynamic> json) {
  return _ProfileLocation.fromJson(json);
}

/// @nodoc
mixin _$ProfileLocation {
  int get id => throw _privateConstructorUsedError;
  int? get profileId => throw _privateConstructorUsedError;
  String? get latitude => throw _privateConstructorUsedError;
  String? get longitude => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;

  /// Serializes this ProfileLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileLocationCopyWith<ProfileLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileLocationCopyWith<$Res> {
  factory $ProfileLocationCopyWith(
    ProfileLocation value,
    $Res Function(ProfileLocation) then,
  ) = _$ProfileLocationCopyWithImpl<$Res, ProfileLocation>;
  @useResult
  $Res call({
    int id,
    int? profileId,
    String? latitude,
    String? longitude,
    String? address,
  });
}

/// @nodoc
class _$ProfileLocationCopyWithImpl<$Res, $Val extends ProfileLocation>
    implements $ProfileLocationCopyWith<$Res> {
  _$ProfileLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? address = freezed,
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
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as String?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileLocationImplCopyWith<$Res>
    implements $ProfileLocationCopyWith<$Res> {
  factory _$$ProfileLocationImplCopyWith(
    _$ProfileLocationImpl value,
    $Res Function(_$ProfileLocationImpl) then,
  ) = __$$ProfileLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int? profileId,
    String? latitude,
    String? longitude,
    String? address,
  });
}

/// @nodoc
class __$$ProfileLocationImplCopyWithImpl<$Res>
    extends _$ProfileLocationCopyWithImpl<$Res, _$ProfileLocationImpl>
    implements _$$ProfileLocationImplCopyWith<$Res> {
  __$$ProfileLocationImplCopyWithImpl(
    _$ProfileLocationImpl _value,
    $Res Function(_$ProfileLocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? address = freezed,
  }) {
    return _then(
      _$ProfileLocationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        profileId: freezed == profileId
            ? _value.profileId
            : profileId // ignore: cast_nullable_to_non_nullable
                  as int?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as String?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileLocationImpl implements _ProfileLocation {
  const _$ProfileLocationImpl({
    required this.id,
    this.profileId,
    this.latitude,
    this.longitude,
    this.address,
  });

  factory _$ProfileLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileLocationImplFromJson(json);

  @override
  final int id;
  @override
  final int? profileId;
  @override
  final String? latitude;
  @override
  final String? longitude;
  @override
  final String? address;

  @override
  String toString() {
    return 'ProfileLocation(id: $id, profileId: $profileId, latitude: $latitude, longitude: $longitude, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileLocationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, profileId, latitude, longitude, address);

  /// Create a copy of ProfileLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileLocationImplCopyWith<_$ProfileLocationImpl> get copyWith =>
      __$$ProfileLocationImplCopyWithImpl<_$ProfileLocationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileLocationImplToJson(this);
  }
}

abstract class _ProfileLocation implements ProfileLocation {
  const factory _ProfileLocation({
    required final int id,
    final int? profileId,
    final String? latitude,
    final String? longitude,
    final String? address,
  }) = _$ProfileLocationImpl;

  factory _ProfileLocation.fromJson(Map<String, dynamic> json) =
      _$ProfileLocationImpl.fromJson;

  @override
  int get id;
  @override
  int? get profileId;
  @override
  String? get latitude;
  @override
  String? get longitude;
  @override
  String? get address;

  /// Create a copy of ProfileLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileLocationImplCopyWith<_$ProfileLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
