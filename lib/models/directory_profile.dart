import 'package:freezed_annotation/freezed_annotation.dart';

part 'directory_profile.freezed.dart';
part 'directory_profile.g.dart';

@freezed
class DirectoryProfile with _$DirectoryProfile {
  const factory DirectoryProfile({
    required int id,
    int? categoryId,
    required String name,
    String? imageUrl,
    String? description,
    @Default(false) bool isFeatured,
    String? createdAt,
    String? updatedAt,
  }) = _DirectoryProfile;

  factory DirectoryProfile.fromJson(Map<String, dynamic> json) =>
      _$DirectoryProfileFromJson(json);
}
