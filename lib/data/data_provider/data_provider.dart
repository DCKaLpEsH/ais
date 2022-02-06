import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gold_india_stocks/common/api_constants.dart';
import 'package:gold_india_stocks/data/models/deal_model.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  const DataProvider(
    this.client,
  );

  final http.Client client;

  Future<dynamic> getBulkData() async {
    final url = Uri.parse(ApiConstants.bulkDealUrl);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final bulkData = json.decode(response.body);
      // print("BULK DATA ${response.body}");
      return response.body;
    }
    throw Exception();
  }

  Future<dynamic> getBlockData() async {
    final url = Uri.parse(ApiConstants.blockDealUrl);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final blockData = json.decode(response.body);
      print("BLOCK DATA ${response.body}");
      return response.body;
    }
    throw Exception();
  }
}
