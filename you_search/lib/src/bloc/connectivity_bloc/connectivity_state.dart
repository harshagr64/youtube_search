part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {
  final bool isConnected;

  ConnectivityConnected(this.isConnected);

  @override
  List<Object> get props => [isConnected];
}

class ConnectivityDisconnected extends ConnectivityState {
  final bool isDisConnected;

  ConnectivityDisconnected(this.isDisConnected);

  @override
  List<Object> get props => [isDisConnected];
}
