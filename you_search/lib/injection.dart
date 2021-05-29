import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:http/http.dart' as http;
import 'package:you_search/src/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:you_search/src/bloc/detail_bloc/detail_bloc.dart';
import 'package:you_search/src/bloc/search_bloc/youtube_search_bloc.dart';
import 'package:you_search/src/network/youtube_data_source.dart';
import 'package:you_search/src/repository/connectivity_repo.dart';
import 'package:you_search/src/repository/youtube_search_repo.dart';

void initKiwi() {
  kiwi.KiwiContainer()
    ..registerInstance(http.Client())
    ..registerFactory((c) => ConnectivityRepo())
    ..registerFactory((c) => Connectivity())
    ..registerFactory((c) => ConnectivityBloc(c.resolve(), c.resolve()))
    ..registerFactory((c) => YoutubeDataSource(c.resolve()))
    ..registerFactory((c) => YoutubeSearchRepo(c.resolve()))
    ..registerFactory((c) => YoutubeSearchBloc(c.resolve()))
    ..registerFactory((c) => DetailBloc(c.resolve()));
}
