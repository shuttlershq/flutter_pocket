import 'package:flutter_pocket/src/models/api_response.dart';

class TxnStatusRequestResponse extends ApiResponse {
  StatusData? statusData;
  TxnStatusRequestResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] ?? {};
    statusData =
        json['data'] != null ? StatusData.fromJson(json['data']) : null;
  }
}

class StatusData {
  String? requestId;
  String? description;
  int? amount;
  String? requestStatus;
  RequestedBy? requestedBy;
  RequestedBy? requestedSentTo;
  Meta? meta;
  String? createdAt;
  String? updatedAt;

  StatusData(
      {this.requestId,
      this.description,
      this.amount,
      this.requestStatus,
      this.requestedBy,
      this.requestedSentTo,
      this.meta,
      this.createdAt,
      this.updatedAt});

  StatusData.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    description = json['description'];
    amount = json['amount'];
    requestStatus = json['request_status'];
    requestedBy = json['requested_by'] != null
        ? RequestedBy.fromJson(json['requested_by'])
        : null;
    requestedSentTo = json['requested_sent_to'] != null
        ? RequestedBy.fromJson(json['requested_sent_to'])
        : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_id'] = requestId;
    data['description'] = description;
    data['amount'] = amount;
    data['request_status'] = requestStatus;
    if (requestedBy != null) {
      data['requested_by'] = requestedBy!.toJson();
    }
    if (requestedSentTo != null) {
      data['requested_sent_to'] = requestedSentTo!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class RequestedBy {
  String? name;
  String? tag;

  RequestedBy({this.name, this.tag});

  RequestedBy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['tag'] = tag;
    return data;
  }
}

class Meta {
  int? userId;
  String? email;

  Meta({this.userId, this.email});

  Meta.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['email'] = email;
    return data;
  }
}
