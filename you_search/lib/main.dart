import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_search/injection.dart';
import 'package:you_search/src/ui/search_page.dart';

void main() {
  initKiwi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.red.shade600,
        accentColor: Colors.red.shade400,
        brightness: Brightness.light,
      ),
      home: SearchPage(),
    );
  }
}
