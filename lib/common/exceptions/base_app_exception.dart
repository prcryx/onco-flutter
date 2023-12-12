class AppException implements Exception {
  final int codeInt;
  final String codeString;
  final String message;
  final String? path;
  final StackTrace? trace;

  AppException({
    required this.codeInt,
    required this.codeString,
    required this.message,
    this.path,
    this.trace
  });
}
