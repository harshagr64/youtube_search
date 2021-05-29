import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_search/injection.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:you_search/src/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:you_search/src/ui/search_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initKiwi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _connectivityBloc = kiwi.KiwiContainer().resolve<ConnectivityBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _connectivityBloc..add(CheckConnectivity()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.red.shade600,
          accentColor: Colors.red.shade400,
          brightness: Brightness.light,
        ),
        home: SearchPage(),
      ),
    );
  }
}
