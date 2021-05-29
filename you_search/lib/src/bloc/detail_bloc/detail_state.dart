part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailSuccess extends DetailState {
  final List<Item> data;
  DetailSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class DetailFailure extends DetailState {
  final String message;

  DetailFailure(this.message);

  @override
  List<Object> get props => [message];
}
