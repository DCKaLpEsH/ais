import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_india_stocks/bloc/block_data/block_data_bloc.dart';
import 'package:gold_india_stocks/common/constants.dart';
import 'package:gold_india_stocks/data/models/stock_model.dart';
import 'package:gold_india_stocks/presentation/widgets/colored_button.dart';
import 'package:gold_india_stocks/presentation/widgets/outline_button.dart';
import 'package:gold_india_stocks/presentation/widgets/search_field.dart';
import 'package:gold_india_stocks/presentation/widgets/stock_card_widget.dart';
import 'package:intl/intl.dart';

class BlockDealWidget extends StatefulWidget {
  const BlockDealWidget({Key? key}) : super(key: key);

  @override
  State<BlockDealWidget> createState() => _BlockDealWidgetState();
}

class _BlockDealWidgetState extends State<BlockDealWidget> {
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
                BlocProvider.of<BlockDataBloc>(context).add(
                  const BlockDataFetchEvent(
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
                BlocProvider.of<BlockDataBloc>(context).add(
                  const BlockDataFetchEvent(
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
                BlocProvider.of<BlockDataBloc>(context).add(
                  const BlockDataFetchEvent(
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
          onChanged: (value) {
            BlocProvider.of<BlockDataBloc>(context).add(
              BlockDataSearchEvent(searchQuery: value),
            );
          },
          onSubmitted: (value) {
            BlocProvider.of<BlockDataBloc>(context).add(
              BlockDataSearchEvent(searchQuery: value),
            );
          },
        ),
        Expanded(
            child: BlocBuilder<BlockDataBloc, BlockDataState>(
          bloc: BlocProvider.of<BlockDataBloc>(context),
          builder: (context, state) {
            if (state is BlockDataInitial) {
              return const Center(
                child: Text(
                  "Press above buttons or search",
                ),
              );
            } else if (state is BlockDataFetchingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BlockDataFetchedState) {
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
            } else if (state is BlockDataErrorState) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else if (state is BlockDataSearchState) {
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
            } else if (state is BlockDataSearchErrorState) {
              return const Center(
                child: Text("No such client found"),
              );
            }
            return const Text(
              "Press above buttons or search",
            );
          },
        ))
      ],
    );
  }
}
