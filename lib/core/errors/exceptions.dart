class FirebaseException implements Exception {
  final String errMsg;
  FirebaseException({
    required this.errMsg,
  });
}
