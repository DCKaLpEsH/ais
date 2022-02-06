import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_india_stocks/presentation/widgets/search_field.dart';
import 'package:gold_india_stocks/bloc/bulk_data/bulk_data_bloc.dart';
import 'package:gold_india_stocks/common/constants.dart';
import 'package:gold_india_stocks/data/models/stock_model.dart';
import 'package:gold_india_stocks/presentation/widgets/colored_button.dart';
import 'package:gold_india_stocks/presentation/widgets/outline_button.dart';
import 'package:gold_india_stocks/presentation/widgets/stock_card_widget.dart';

class BulkDealWidget extends StatefulWidget {
  BulkDealWidget({Key? key}) : super(key: key);

  @override
  State<BulkDealWidget> createState() => _BulkDealWidgetState();
}

class _BulkDealWidgetState extends State<BulkDealWidget> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: height * 0.04,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyOutlineButton(
              onTap: () {
                BlocProvider.of<BulkDataBloc>(context).add(
                  const BulkDataFetchEvent(
                    dealType: DealType.ALL,
                  ),
                );
                searchController.clear();
                FocusScope.of(context).requestFocus(
                  FocusNode(),
                );
              },
            ),
            const SizedBox(
              width: 20,
            ),
            ColoredButton(
              onTap: () {
                BlocProvider.of<BulkDataBloc>(context).add(
                  const BulkDataFetchEvent(
                    dealType: DealType.BUY,
                  ),
                );
                searchController.clear();
                FocusScope.of(context).requestFocus(
                  FocusNode(),
                );
              },
              btnColor: Constants.green,
              btnTitle: "Buy",
            ),
            const SizedBox(
              width: 20,
            ),
            ColoredButton(
              onTap: () {
                BlocProvider.of<BulkDataBloc>(context).add(
                  const BulkDataFetchEvent(
                    dealType: DealType.SELL,
                  ),
                );
                searchController.clear();
                FocusScope.of(context).requestFocus(
                  FocusNode(),
                );
                print("SELL EVENT");
              },
              btnTitle: "Sell",
              btnColor: Constants.red,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        SearchField(
          height: height,
          width: width,
          searchController: searchController,
          onSubmitted: (value) {
            BlocProvider.of<BulkDataBloc>(context).add(
              BulkDataSearchEvent(searchQuery: value),
            );
          },
          onChanged: (value) {
            BlocProvider.of<BulkDataBloc>(context).add(
              BulkDataSearchEvent(searchQuery: value),
            );
          },
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Expanded(
          child: BlocBuilder<BulkDataBloc, BulkDataState>(
            bloc: BlocProvider.of<BulkDataBloc>(context),
            builder: (context, state) {
              if (state is BulkDataFetchedState) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    print(state.stocks[index].dealType!);
                    return StockCardWidget(
                      height: height,
                      width: width,
                      index: index,
                      stock: state.stocks[index],
                    );
                  },
                  itemCount: state.stocks.length,
                  physics: const BouncingScrollPhysics(),
                );
              } else if (state is BulkDataFetchingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is BulkDataSearchState) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return StockCardWidget(
                      height: height,
                      width: width,
                      index: index,
                      stock: state.stocks[index],
                    );
                  },
                  itemCount: state.stocks.length,
                );
              } else if (state is BulkDataInitialState) {
                return const Center(
                  child: Text(
                    "Press a button or search for your query",
                  ),
                );
              } else if (state is BulkDataSearchErrorState) {
                return const Center(
                  child: Text("No such client found"),
                );
              } else {
                return const Center(
                  child: Text(
                    "Socket Exception",
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
