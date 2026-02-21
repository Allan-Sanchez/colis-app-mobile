import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_location.freezed.dart';
part 'profile_location.g.dart';

@freezed
class ProfileLocation with _$ProfileLocation {
  const factory ProfileLocation({
    required int id,
    int? profileId,
    String? latitude,
    String? longitude,
    String? address,
  }) = _ProfileLocation;

  factory ProfileLocation.fromJson(Map<String, dynamic> json) =>
      _$ProfileLocationFromJson(json);
}
