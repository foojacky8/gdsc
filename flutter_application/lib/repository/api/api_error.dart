class ApiError {
  final String error;

  ApiError({required this.error});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(error: json['error']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    return data;
  }
}