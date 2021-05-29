import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:you_search/src/repository/connectivity_repo.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityRepo _connectivityRepo;
  final Connectivity _connectivity;
  StreamSubscription connectivityStreamSubscription;
  ConnectivityBloc(this._connectivityRepo, this._connectivity)
      : super(ConnectivityInitial());

  @override
  Stream<ConnectivityState> mapEventToState(
    ConnectivityEvent event,
  ) async* {
    if (event is CheckConnectivity) {
      print('checking connection');
      connectivityStreamSubscription =
          _connectivity.onConnectivityChanged.listen((event) async{
        print('checked');
        if (event == ConnectivityResult.mobile ||
            event == ConnectivityResult.wifi) {
          print('true');
          try {
            await _connectivityRepo.checkConnectivity();
            emit(ConnectivityConnected(true));
          } on SocketException catch (_) {
            emit(ConnectivityDisconnected(true));
          }
        } else if (event == ConnectivityResult.none) {
          print(false);
          emit(ConnectivityDisconnected(true));
        }
      });
    }
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
