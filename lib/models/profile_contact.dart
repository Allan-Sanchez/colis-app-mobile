import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_contact.freezed.dart';
part 'profile_contact.g.dart';

@freezed
class ProfileContact with _$ProfileContact {
  const factory ProfileContact({
    required int id,
    int? profileId,
    String? phoneNumber,
    String? email,
  }) = _ProfileContact;

  factory ProfileContact.fromJson(Map<String, dynamic> json) =>
      _$ProfileContactFromJson(json);
}
