class PatronizeException implements Exception {
  String? message;

  PatronizeException(this.message);

  @override
  String toString() {
    if (message == null) return 'Unknown Error';
    return message!;
  }
}

class AuthenticationException extends PatronizeException {
  AuthenticationException(String message) : super(message);
}
