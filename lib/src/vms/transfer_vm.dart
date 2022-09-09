import 'dart:async';

import 'package:flutter/material.dart';

import '../models/models.dart';
import '../service/service.dart';

enum ViewState {
  initial,
  loading,
  loaded,
  awaitingStatus,
  statusRetrieved,
  error,
}

class FundRequestVm extends ChangeNotifier {
  late TransferServiceContract transferService;

  ViewState _state = ViewState.initial;
  ViewState get state => _state;
  setState(ViewState value) {
    _state = value;
    notifyListeners();
  }

  String? _errorMessage;
  String? get error => _errorMessage;

  StatusData? _txnStatusData;
  StatusData? get txnStatusData => _txnStatusData;

  RequestData? _requestData;
  RequestData? get requestData => _requestData;

  FundRequestVm({
    required String key,
    required String baseUrl,
  }) {
    transferService = TransferService(key, baseUrl);
  }

  // call transfer request
  Future<void> transferRequest({required TransferRequestBody body}) async {
    try {
      setState(ViewState.loading);
      TransferRequestResponse response =
          await transferService.transferRequest(body.toJson());
      _requestData = response.statusData;
      setState(ViewState.loaded);
      Timer.periodic(const Duration(seconds: 10),
          (Timer t) => queryStatus(id: _requestData!.requestId.toString()));
    } catch (e) {
      _errorMessage = e as String;
      setState(ViewState.error);
    }
  }

  // call transaction status every 10 seconds
  Future<void> queryStatus({String? id}) async {
    setState(ViewState.awaitingStatus);
    TxnStatusRequestResponse response = await transferService
        .reQueryTransaction(_requestData?.requestId?.toString() ?? id!);
    if (response.statusData!.requestStatus!.toLowerCase() == 'accepted') {
      _txnStatusData = response.statusData;
      setState(ViewState.statusRetrieved);
    } else {
      setState(ViewState.awaitingStatus);
    }
  }
}
