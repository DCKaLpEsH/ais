import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gold_india_stocks/data/models/stock_model.dart';
import 'package:gold_india_stocks/data/repository/get_deal_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stream_transform/stream_transform.dart';
part 'bulk_data_event.dart';
part 'bulk_data_state.dart';

class BulkDataBloc extends Bloc<BulkDataEvent, BulkDataState> {
  final GetDealRepository getDealRepository;

  BulkDataBloc(
    this.getDealRepository,
  ) : super(BulkDataInitialState()) {
    on<BulkDataEvent>((event, emit) async {
      final list = await getDealRepository.getBulkDeal();
      if (event is BulkDataInitialEvent) {
        emit(BulkDataInitialState());
      } else if (event is BulkDataFetchEvent) {
        emit(
          BulkDataFetchingState(),
        );
        final stocks = list.where(
          (element) => element.dealType == event.dealType,
        );
        print(stocks.length);
        if (stocks.isEmpty) {
          emit(
            BulkDataFetchedState(
              stocks: list,
            ),
          );
        } else {
          emit(
            BulkDataFetchedState(
              stocks: stocks.toList(),
            ),
          );
        }
      } else if (event is BulkDataSearchEvent) {
        final searchedList = list.where(
          (element) => element.clientName.toLowerCase().contains(
                event.searchQuery.toLowerCase(),
              ),
        );
        if (searchedList.isEmpty) {
          emit(
            BulkDataSearchErrorState(),
          );
        } else {
          emit(
            BulkDataSearchState(
              stocks: searchedList.toList(),
            ),
          );
        }
      } else {
        print("ERROR");
        emit(
          BulkDataErrorState(),
        );
      }
    });
  }
}
