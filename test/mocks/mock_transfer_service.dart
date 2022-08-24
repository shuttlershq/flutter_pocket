import 'dart:convert';

import 'package:flutter_pocket/src/models/models.dart';
import 'package:flutter_pocket/src/service/service.dart';

class MockTransferService
    with BaseApiService
    implements TransferServiceContract {
  @override
  Future<TransferRequestResponse> transferRequest(
      Map<String, dynamic> fields) async {
    var body = """{
      "status": true,
      "message": "Request sent",
      "data": {"request_id": 491025}
    }""";

    Map<String, dynamic> responseBody = json.decode(body);
    return TransferRequestResponse.fromJson(responseBody);
  }

  @override
  Future<TxnStatusRequestResponse> reQueryTransaction(String id) async {
    var body = """{
    "status": true,
    "message": "Request fetch successfully",
    "data": {
        "request_id": "490946",
        "description": "Send me money joor",
        "amount": 100,
        "request_status": "pending",
        "requested_by": {
            "name": "shuttlers metropolitan ",
            "tag": "jakuzy009"
        },
        "requested_sent_to": {
            "name": "Israel Alagbe",
            "tag": "israel"
        },
        "meta": {
            "user_id": 23,
            "email": "abadasamuelosp@gmail.com"
        },
        "created_at": "2022-08-23T15:56:49.000Z",
        "updated_at": "2022-08-23T15:56:49.000Z"
    }
}""";
    Map<String, dynamic> responseBody = json.decode(body);
    return TxnStatusRequestResponse.fromJson(responseBody);
  }
}
