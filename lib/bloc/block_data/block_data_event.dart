part of 'block_data_bloc.dart';

abstract class BlockDataEvent extends Equatable {
  const BlockDataEvent();

  @override
  List<Object> get props => [];
}

class BlockDataFetchEvent extends BlockDataEvent {
  final DealType dealType;
  const BlockDataFetchEvent({
    required this.dealType,
  });
  @override
  List<Object> get props => [dealType];
}

class BlockDataSearchEvent extends BlockDataEvent {
  final String searchQuery;
  const BlockDataSearchEvent({
    required this.searchQuery,
  });
  @override
  List<Object> get props => [searchQuery];
}
