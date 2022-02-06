part of 'bulk_data_bloc.dart';

abstract class BulkDataState extends Equatable {
  const BulkDataState();

  @override
  List<Object> get props => [];
}

class BulkDataInitialState extends BulkDataState {}

class BulkDataFetchedState extends BulkDataState {
  final List<StockModel> stocks;
  const BulkDataFetchedState({
    required this.stocks,
  });
  @override
  List<Object> get props => [stocks];
}

class BulkDataFetchingState extends BulkDataState {}

class BulkDataErrorState extends BulkDataState {}

class BulkDataSearchErrorState extends BulkDataState {}

class BulkDataSearchState extends BulkDataState {
  final List<StockModel> stocks;
  const BulkDataSearchState({
    required this.stocks,
  });
  @override
  List<Object> get props => [stocks];
}
