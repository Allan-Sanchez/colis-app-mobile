class Review {
  final int id;
  final String entityType;
  final int entityId;
  final int rating;
  final String? comment;
  final String deviceId;
  final String createdAt;

  const Review({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.rating,
    this.comment,
    required this.deviceId,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json['id'] as int,
        entityType: json['entityType'] as String,
        entityId: json['entityId'] as int,
        rating: json['rating'] as int,
        comment: json['comment'] as String?,
        deviceId: json['deviceId'] as String? ?? '',
        createdAt: json['createdAt'] as String? ?? '',
      );
}
