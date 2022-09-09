import 'dart:convert';
import 'dart:io';

import 'package:flutter_pocket/src/service/contracts/transfer_service_contract.dart';
import 'package:flutter_pocket/src/utils/exceptions.dart';

import '../models/transfer_request_response.dart';
import '../models/txn_status_response.dart';
import 'base_service.dart';
import 'package:http/http.dart' as http;

class TransferService with BaseApiService implements TransferServiceContract {
  String key;
  String url;
  TransferService(
    this.key,
    this.url,
  );
  @override
  Future<TransferRequestResponse> transferRequest(
      Map<String, dynamic> fields) async {
    String? message;
    try {
      headers.putIfAbsent('Authorization', () => 'Bearer $key');
      String url = '${this.url}/pocket/initialize';
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode(fields), headers: headers);
      var body = response.body;

      var statusCode = response.statusCode;

      message = json.decode(body)['message'] ?? 'Unknown server response';

      switch (statusCode) {
        case HttpStatus.ok:
          Map<String, dynamic> responseBody = json.decode(body);
          return TransferRequestResponse.fromJson(responseBody);
        case HttpStatus.unauthorized:
          Map<String, dynamic> responseBody = json.decode(body);
          var response = TransferRequestResponse.fromJson(responseBody);
          throw PatronizeException(response.message ?? 'Unauthorized access');
        default:
          throw PatronizeException(message ?? 'Unknown server response');
      }
    } catch (e) {
      throw PatronizeException(message ?? 'Unknown server response');
    }
  }

  @override
  Future<TxnStatusRequestResponse> reQueryTransaction(String id) async {
    try {
      headers.putIfAbsent('Authorization', () => 'Bearer $key');
      String url = '${this.url}/pocket/transaction/$id';

      http.Response response = await http.get(Uri.parse(url), headers: headers);
      var body = response.body;
      var statusCode = response.statusCode;
      if (statusCode == HttpStatus.ok) {
        Map<String, dynamic> responseBody = json.decode(body);
        return TxnStatusRequestResponse.fromJson(responseBody);
      } else {
        throw PatronizeException('requery transaction failed with status code: '
            '$statusCode and response: $body');
      }
    } catch (e) {
      throw PatronizeException('Unknown server response');
    }
  }
}
