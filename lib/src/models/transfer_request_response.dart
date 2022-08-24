import 'api_response.dart';

class TransferRequestResponse extends ApiResponse {
  RequestData? statusData;
  TransferRequestResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] ?? {};
    statusData =
        json['data'] != null ? RequestData.fromJson(json['data']) : null;
  }

  @override
  String toString() {
    return 'TransferRequestApiResponse{requestId: ${data?["request_id"]}, status: $status}';
  }
}

class RequestData {
  int? requestId;

  RequestData({this.requestId});

  RequestData.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_id'] = requestId;
    return data;
  }
}
