// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProfileContact _$ProfileContactFromJson(Map<String, dynamic> json) {
  return _ProfileContact.fromJson(json);
}

/// @nodoc
mixin _$ProfileContact {
  int get id => throw _privateConstructorUsedError;
  int? get profileId => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  /// Serializes this ProfileContact to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileContactCopyWith<ProfileContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileContactCopyWith<$Res> {
  factory $ProfileContactCopyWith(
    ProfileContact value,
    $Res Function(ProfileContact) then,
  ) = _$ProfileContactCopyWithImpl<$Res, ProfileContact>;
  @useResult
  $Res call({int id, int? profileId, String? phoneNumber, String? email});
}

/// @nodoc
class _$ProfileContactCopyWithImpl<$Res, $Val extends ProfileContact>
    implements $ProfileContactCopyWith<$Res> {
  _$ProfileContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = freezed,
    Object? phoneNumber = freezed,
    Object? email = freezed,
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
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileContactImplCopyWith<$Res>
    implements $ProfileContactCopyWith<$Res> {
  factory _$$ProfileContactImplCopyWith(
    _$ProfileContactImpl value,
    $Res Function(_$ProfileContactImpl) then,
  ) = __$$ProfileContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int? profileId, String? phoneNumber, String? email});
}

/// @nodoc
class __$$ProfileContactImplCopyWithImpl<$Res>
    extends _$ProfileContactCopyWithImpl<$Res, _$ProfileContactImpl>
    implements _$$ProfileContactImplCopyWith<$Res> {
  __$$ProfileContactImplCopyWithImpl(
    _$ProfileContactImpl _value,
    $Res Function(_$ProfileContactImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = freezed,
    Object? phoneNumber = freezed,
    Object? email = freezed,
  }) {
    return _then(
      _$ProfileContactImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        profileId: freezed == profileId
            ? _value.profileId
            : profileId // ignore: cast_nullable_to_non_nullable
                  as int?,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileContactImpl implements _ProfileContact {
  const _$ProfileContactImpl({
    required this.id,
    this.profileId,
    this.phoneNumber,
    this.email,
  });

  factory _$ProfileContactImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileContactImplFromJson(json);

  @override
  final int id;
  @override
  final int? profileId;
  @override
  final String? phoneNumber;
  @override
  final String? email;

  @override
  String toString() {
    return 'ProfileContact(id: $id, profileId: $profileId, phoneNumber: $phoneNumber, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileContactImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, profileId, phoneNumber, email);

  /// Create a copy of ProfileContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileContactImplCopyWith<_$ProfileContactImpl> get copyWith =>
      __$$ProfileContactImplCopyWithImpl<_$ProfileContactImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileContactImplToJson(this);
  }
}

abstract class _ProfileContact implements ProfileContact {
  const factory _ProfileContact({
    required final int id,
    final int? profileId,
    final String? phoneNumber,
    final String? email,
  }) = _$ProfileContactImpl;

  factory _ProfileContact.fromJson(Map<String, dynamic> json) =
      _$ProfileContactImpl.fromJson;

  @override
  int get id;
  @override
  int? get profileId;
  @override
  String? get phoneNumber;
  @override
  String? get email;

  /// Create a copy of ProfileContact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileContactImplCopyWith<_$ProfileContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
