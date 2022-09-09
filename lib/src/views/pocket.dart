import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pocket/src/views/widgets.dart';

import '../models/models.dart';
import '../vms/transfer_vm.dart';

class PocketView extends StatefulWidget {
  final String pocketKey;
  final String baseUrl;
  final TransferRequestBody body;
  const PocketView({
    Key? key,
    required this.pocketKey,
    required this.body,
    required this.baseUrl,
  }) : super(key: key);

  @override
  State<PocketView> createState() => _PocketViewState();
}

class _PocketViewState extends State<PocketView> {
  late FundRequestVm vm;

  @override
  void initState() {
    vm = FundRequestVm(
      key: widget.pocketKey,
      baseUrl: widget.baseUrl,
    );
    vm.addListener(() {
      if (mounted) setState(() {});
    });
    vm.transferRequest(body: widget.body);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.delayed(const Duration(seconds: 0), () => false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pay with pocket'),
          centerTitle: true,
          leading: BackButton(
              onPressed: () => Navigator.pop(context, vm.txnStatusData)),
        ),
        body: Builder(builder: (context) {
          if (vm.state == ViewState.initial) {
            return const Center(child: Text('Pay with abeg!'));
          }
          if (vm.state == ViewState.loading) {
            return const Center(
              child: CupertinoActivityIndicator(radius: 30),
            );
          }
          if (vm.state == ViewState.loaded) {
            return Center(
              child: InfoUpdateState(
                description: 'Request sent!',
                message: 'Accept the payment request on your pocket app',
                onReload: vm.queryStatus,
              ),
            );
          }
          if (vm.state == ViewState.awaitingStatus) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CupertinoActivityIndicator(radius: 30),
                SizedBox(height: 16),
                Text('Checking for transaction status...'),
              ],
            ));
          }
          if (vm.state == ViewState.statusRetrieved) {
            Navigator.of(context).pop(vm.txnStatusData);
          }
          if (vm.state == ViewState.error) {
            return Center(child: Text(vm.error ?? 'An error occurred!'));
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
