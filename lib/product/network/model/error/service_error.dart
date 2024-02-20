class ServiceError {
  final String errorMessage;
  final int errorCode;

  ServiceError({required this.errorMessage, required this.errorCode});

  factory ServiceError.fromJson(Map<String, dynamic> map) {
    return ServiceError(
      errorMessage: map['error']  ??  "",
      errorCode: map['errorCode']  ?? 200,
    );
  }
}
