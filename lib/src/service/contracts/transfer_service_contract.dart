import 'package:flutter_pocket/src/models/transfer_request_response.dart';
import 'package:flutter_pocket/src/models/txn_status_response.dart';

abstract class TransferServiceContract {
  Future<TransferRequestResponse> transferRequest(Map<String, dynamic> fields);

  Future<TxnStatusRequestResponse> reQueryTransaction(String id);
}
