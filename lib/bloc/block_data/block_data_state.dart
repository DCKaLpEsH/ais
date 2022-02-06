part of 'block_data_bloc.dart';

abstract class BlockDataState extends Equatable {
  const BlockDataState();

  @override
  List<Object> get props => [];
}

class BlockDataInitial extends BlockDataState {}

class BlockDataFetchingState extends BlockDataState {}

class BlockDataFetchedState extends BlockDataState {
  final List<StockModel> stocks;
  const BlockDataFetchedState({
    required this.stocks,
  });
  @override
  List<Object> get props => [stocks];
}

class BlockDataErrorState extends BlockDataState {
  final AppErrors error;
  BlockDataErrorState({
    required this.error,
  });
  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class BlockDataSearchState extends BlockDataState {
  final List<StockModel> stocks;
  const BlockDataSearchState({
    required this.stocks,
  });
  @override
  List<Object> get props => [stocks];
}

class BlockDataSearchErrorState extends BlockDataState {}
