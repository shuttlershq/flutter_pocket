import 'dart:io';

mixin BaseApiService {
  final Map<String, String> headers = {
    // HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  final String baseUrl =
      'https://rllwjl4z6b.execute-api.eu-central-1.amazonaws.com/api/v1';
}
