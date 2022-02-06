class StockModel {
  StockModel({
    this.finCode,
    required this.clientName,
    this.dealType,
    required this.quantity,
    required this.value,
    required this.tradePrice,
    this.dealDate,
    required this.exchange,
  });

  String? finCode;
  String clientName;
  DealType? dealType;
  String quantity;
  String value;
  String tradePrice;
  DateTime? dealDate;
  Exchange exchange;

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        finCode: json["FinCode"],
        clientName: json["ClientName"],
        dealType: dealTypeValues.map![json["DealType"]],
        quantity: json["Quantity"],
        value: json["Value"],
        tradePrice: json["TradePrice"],
        dealDate: DateTime.parse(json["DealDate"]),
        exchange: exchangeValues.map![json["Exchange"]]!,
      );

  Map<String, dynamic> toJson() => {
        "FinCode": finCode,
        "ClientName": clientName,
        "DealType": dealTypeValues.reverse[dealType],
        "Quantity": quantity,
        "Value": value,
        "TradePrice": tradePrice,
        "DealDate": dealDate!.toIso8601String(),
        "Exchange": exchangeValues.reverse[exchange],
      };
}

enum DealType {
  SELL,
  BUY,
  ALL,
}

final dealTypeValues = EnumValues({"BUY": DealType.BUY, "SELL": DealType.SELL});

enum Exchange { BSE, NSE }

final exchangeValues = EnumValues({"BSE": Exchange.BSE, "NSE": Exchange.NSE});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
