import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_social.freezed.dart';
part 'profile_social.g.dart';

@freezed
class ProfileSocial with _$ProfileSocial {
  const factory ProfileSocial({
    required int id,
    int? profileId,
    required String platform,
    required String url,
  }) = _ProfileSocial;

  factory ProfileSocial.fromJson(Map<String, dynamic> json) =>
      _$ProfileSocialFromJson(json);
}
