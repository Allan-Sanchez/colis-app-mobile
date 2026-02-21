import 'package:freezed_annotation/freezed_annotation.dart';

part 'directory_category.freezed.dart';
part 'directory_category.g.dart';

@freezed
class DirectoryCategory with _$DirectoryCategory {
  const factory DirectoryCategory({
    required int id,
    required String name,
    String? imageUrl,
    String? createdAt,
    String? updatedAt,
  }) = _DirectoryCategory;

  factory DirectoryCategory.fromJson(Map<String, dynamic> json) =>
      _$DirectoryCategoryFromJson(json);
}
