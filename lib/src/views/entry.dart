import 'package:flutter/cupertino.dart';
import 'package:flutter_pocket/src/views/pocket.dart';

import '../models/models.dart';

class FlutterPocket {
  BuildContext context;
  String key;
  String baseUrl;
  TransferRequestBody body;

  FlutterPocket({
    required this.context,
    required this.key,
    required this.body,
    required this.baseUrl,
  }) : assert(key.isNotEmpty);

  /// Starts pocket payment
  Future<StatusData?> pay() async {
    StatusData? status = await Navigator.push<StatusData>(
      context,
      CupertinoPageRoute(
        builder: (context) => PocketView(
          pocketKey: key,
          body: body,
          baseUrl: baseUrl,
        ),
      ),
    );
    return status;
  }
}
