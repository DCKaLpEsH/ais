import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gold_india_stocks/common/enum_constants.dart';
import 'package:gold_india_stocks/data/models/stock_model.dart';
import 'package:gold_india_stocks/data/repository/get_deal_repository.dart';

part 'block_data_event.dart';
part 'block_data_state.dart';

class BlockDataBloc extends Bloc<BlockDataEvent, BlockDataState> {
  final GetDealRepository getDealRepository;
  BlockDataBloc(
    this.getDealRepository,
  ) : super(BlockDataInitial()) {
    on<BlockDataEvent>(getBlockDeals);
  }

  Future<void> getBlockDeals(
      BlockDataEvent event, Emitter<BlockDataState> emit) async {
    final list = await getDealRepository.getBlockDeal();
    if (event is BlockDataFetchEvent) {
      emit(
        BlockDataFetchingState(),
      );
      final stocks = list.where(
        (element) => element.dealType == event.dealType,
      );
      print(stocks.length);
      if (stocks.isEmpty) {
        emit(
          BlockDataFetchedState(
            stocks: list,
          ),
        );
      } else {
        emit(
          BlockDataFetchedState(
            stocks: stocks.toList(),
          ),
        );
      }
    } else if (event is BlockDataSearchEvent) {
      final searchedList = list.where(
        (element) => element.clientName.toLowerCase().contains(
              event.searchQuery.toLowerCase(),
            ),
      );
      if (searchedList.isEmpty) {
        emit(
          BlockDataSearchErrorState(),
        );
      } else {
        emit(
          BlockDataSearchState(
            stocks: searchedList.toList(),
          ),
        );
      }
    } else {
      emit(
        BlockDataErrorState(
          error: AppErrors.SOCKET,
        ),
      );
    }
  }
}
