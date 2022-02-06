import 'dart:convert';

import 'stock_model.dart';

class DealModel {
  DealModel({
    required this.data,
    this.status,
  });

  List<StockModel> data;
  String? status;

  factory DealModel.fromJson(Map<String, dynamic> json) => DealModel(
        data: List<StockModel>.from(
            json["Data"].map((x) => StockModel.fromJson(x))),
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "Status": status,
      };
}
