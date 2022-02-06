import 'package:flutter/material.dart';

import 'package:gold_india_stocks/common/constants.dart';
import 'package:gold_india_stocks/data/models/stock_model.dart';
import 'package:intl/intl.dart';

class StockCardWidget extends StatelessWidget {
  const StockCardWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.index,
    required this.stock,
  }) : super(key: key);

  final double height;
  final double width;
  final int index;
  final StockModel stock;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height * 0.15,
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: 5.0,
      ),
      padding: const EdgeInsets.only(
        bottom: 8.0,
        top: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(height * 0.01),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: height * 0.14,
            width: 4.0,
            color: stock.dealType == DealType.SELL
                ? Constants.red
                : Constants.green,
            margin: EdgeInsets.only(
              left: width * 0.01,
              right: width * 0.05,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: width * 0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        stock.clientName,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      DateFormat('d MMM y').format(stock.dealDate!),
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: stock.dealType == DealType.BUY
                          ? "Bought ${stock.quantity} shares"
                          : "Sold ${stock.quantity} shares",
                      style: TextStyle(
                        color: stock.dealType == DealType.BUY
                            ? Constants.green
                            : Constants.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: " @ Rs ${stock.tradePrice}",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                stock.value.toString().length >= 8
                    ? "Value : Rs ${stock.value.toString().substring(0, 3)}.${stock.value.toString().substring(3, 4)} cr"
                    : stock.tradePrice.toString().length > 7
                        ? "Value : Rs ${stock.value.toString().substring(0, 2)}.${stock.value.toString().substring(2, 3)} L"
                        : "Value : Rs ${stock.value}",
                // "Value: Rs. ${stock.value}",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
