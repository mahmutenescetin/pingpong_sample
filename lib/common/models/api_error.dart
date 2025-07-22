class ApiError {
  final int errorCode;
  final String message;
  final String description;

  const ApiError({
    required this.errorCode,
    required this.message,
    required this.description,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    late final int apiErrorCode;

    try {
      apiErrorCode = json['errorCode'] as int;
    } catch (e) {
      apiErrorCode = -1;
    }

    final apiErrorMessage = json['message'] ?? "Bir şeyler ters gitti";
    final apiErrorDescription = json['description'] ?? "Bir şeyler ters gitti";

    return ApiError(
      errorCode: apiErrorCode,
      message: apiErrorMessage,
      description: apiErrorDescription,
    );
  }
}
