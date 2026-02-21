// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RestaurantLocation _$RestaurantLocationFromJson(Map<String, dynamic> json) {
  return _RestaurantLocation.fromJson(json);
}

/// @nodoc
mixin _$RestaurantLocation {
  int get id => throw _privateConstructorUsedError;
  int? get restaurantId => throw _privateConstructorUsedError;
  String? get latitude => throw _privateConstructorUsedError;
  String? get longitude => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;

  /// Serializes this RestaurantLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantLocationCopyWith<RestaurantLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantLocationCopyWith<$Res> {
  factory $RestaurantLocationCopyWith(
    RestaurantLocation value,
    $Res Function(RestaurantLocation) then,
  ) = _$RestaurantLocationCopyWithImpl<$Res, RestaurantLocation>;
  @useResult
  $Res call({
    int id,
    int? restaurantId,
    String? latitude,
    String? longitude,
    String? address,
  });
}

/// @nodoc
class _$RestaurantLocationCopyWithImpl<$Res, $Val extends RestaurantLocation>
    implements $RestaurantLocationCopyWith<$Res> {
  _$RestaurantLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = freezed,
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
            restaurantId: freezed == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$RestaurantLocationImplCopyWith<$Res>
    implements $RestaurantLocationCopyWith<$Res> {
  factory _$$RestaurantLocationImplCopyWith(
    _$RestaurantLocationImpl value,
    $Res Function(_$RestaurantLocationImpl) then,
  ) = __$$RestaurantLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int? restaurantId,
    String? latitude,
    String? longitude,
    String? address,
  });
}

/// @nodoc
class __$$RestaurantLocationImplCopyWithImpl<$Res>
    extends _$RestaurantLocationCopyWithImpl<$Res, _$RestaurantLocationImpl>
    implements _$$RestaurantLocationImplCopyWith<$Res> {
  __$$RestaurantLocationImplCopyWithImpl(
    _$RestaurantLocationImpl _value,
    $Res Function(_$RestaurantLocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? address = freezed,
  }) {
    return _then(
      _$RestaurantLocationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        restaurantId: freezed == restaurantId
            ? _value.restaurantId
            : restaurantId // ignore: cast_nullable_to_non_nullable
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
class _$RestaurantLocationImpl implements _RestaurantLocation {
  const _$RestaurantLocationImpl({
    required this.id,
    this.restaurantId,
    this.latitude,
    this.longitude,
    this.address,
  });

  factory _$RestaurantLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestaurantLocationImplFromJson(json);

  @override
  final int id;
  @override
  final int? restaurantId;
  @override
  final String? latitude;
  @override
  final String? longitude;
  @override
  final String? address;

  @override
  String toString() {
    return 'RestaurantLocation(id: $id, restaurantId: $restaurantId, latitude: $latitude, longitude: $longitude, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantLocationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, restaurantId, latitude, longitude, address);

  /// Create a copy of RestaurantLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantLocationImplCopyWith<_$RestaurantLocationImpl> get copyWith =>
      __$$RestaurantLocationImplCopyWithImpl<_$RestaurantLocationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantLocationImplToJson(this);
  }
}

abstract class _RestaurantLocation implements RestaurantLocation {
  const factory _RestaurantLocation({
    required final int id,
    final int? restaurantId,
    final String? latitude,
    final String? longitude,
    final String? address,
  }) = _$RestaurantLocationImpl;

  factory _RestaurantLocation.fromJson(Map<String, dynamic> json) =
      _$RestaurantLocationImpl.fromJson;

  @override
  int get id;
  @override
  int? get restaurantId;
  @override
  String? get latitude;
  @override
  String? get longitude;
  @override
  String? get address;

  /// Create a copy of RestaurantLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantLocationImplCopyWith<_$RestaurantLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
