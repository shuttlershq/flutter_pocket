class TransferRequestBody {
  int amount;
  String tag;
  String description;
  Map<String, dynamic>? meta;

  TransferRequestBody({
    required this.amount,
    required this.tag,
    required this.description,
    this.meta = const {},
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['tag'] = tag;
    data['description'] = description;
    data['meta'] = meta;
    return data;
  }
}
