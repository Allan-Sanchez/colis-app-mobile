class ApiResponse<T> {
  final bool success;
  final int httpStatus;
  final String appCode;
  final String message;
  final T? data;

  ApiResponse({
    required this.success,
    required this.httpStatus,
    required this.appCode,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool,
      httpStatus: json['httpStatus'] as int,
      appCode: json['appCode'] as String,
      message: json['message'] as String,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'] as T?,
    );
  }
}
