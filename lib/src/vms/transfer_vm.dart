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

  String? errorMessage;
  String? get error => errorMessage;

  StatusData? _txnStatusData;
  StatusData? get txnStatusData => _txnStatusData;

  FundRequestVm({
    TransferServiceContract? transferService,
    String? key,
    String? baseUrl,
  }) : assert((transferService != null && key == null) ||
            (transferService == null && key != null)) {
    this.transferService = transferService ?? TransferService(key!, baseUrl!);
  }

  // call transfer request
  Future<void> transferRequest({required TransferRequestBody body}) async {
    try {
      setState(ViewState.loading);
      TransferRequestResponse response =
          await transferService.transferRequest(body.toJson());
      setState(ViewState.loaded);
      Timer.periodic(
          const Duration(seconds: 10),
          (Timer t) =>
              queryStatus(id: response.statusData!.requestId.toString()));
    } catch (e) {
      setState(ViewState.error);
    }
  }

  // call transaction status every 10 seconds
  Future<void> queryStatus({String? id}) async {
    setState(ViewState.awaitingStatus);
    TxnStatusRequestResponse response = await transferService
        .reQueryTransaction(_txnStatusData?.requestId ?? id!);
    if (response.statusData!.requestStatus!.toLowerCase() == 'accepted') {
      setState(ViewState.statusRetrieved);
    } else {
      setState(ViewState.awaitingStatus);
    }
  }
}
