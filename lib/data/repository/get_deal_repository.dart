import 'dart:convert';
import 'dart:io';

import 'package:gold_india_stocks/common/enum_constants.dart';
import 'package:gold_india_stocks/data/data_provider/data_provider.dart';
import 'package:gold_india_stocks/data/models/deal_model.dart';
import 'package:gold_india_stocks/data/models/stock_model.dart';

abstract class GetDealRepository {
  Future<List<StockModel>> getBulkDeal();
  Future<List<StockModel>> getBlockDeal();
}

class GetDealRepositoryImpl extends GetDealRepository {
  final DataProvider dataProvider;
  GetDealRepositoryImpl({
    required this.dataProvider,
  });
  @override
  Future<List<StockModel>> getBulkDeal() async {
    try {
      final data = await dataProvider.getBulkData();
      print("DATA $data");
      return DealModel.fromJson(json.decode(data)).data;
    } on SocketException {
      throw AppErrors.SOCKET;
    }
  }

  @override
  Future<List<StockModel>> getBlockDeal() async {
    try {
      final data = await dataProvider.getBlockData();
      print("BLOCK $data");
      return DealModel.fromJson(json.decode(data)).data;
    } on SocketException {
      throw AppErrors.SOCKET;
    }
  }
}
