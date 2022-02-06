part of 'bulk_data_bloc.dart';

abstract class BulkDataEvent extends Equatable {
  const BulkDataEvent();

  @override
  List<Object> get props => [];
}

class BulkDataInitialEvent extends BulkDataEvent {}

class BulkDataFetchEvent extends BulkDataEvent {
  final DealType dealType;
  const BulkDataFetchEvent({
    required this.dealType,
  });
  @override
  List<Object> get props => [dealType];
}

class BulkDataSearchEvent extends BulkDataEvent {
  final String searchQuery;
  const BulkDataSearchEvent({
    required this.searchQuery,
  });
  @override
  List<Object> get props => [searchQuery];
}
