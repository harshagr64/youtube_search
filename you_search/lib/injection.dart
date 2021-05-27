import 'package:flutter/foundation.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:http/http.dart' as http;
import 'package:you_search/src/bloc/youtube_search_bloc.dart';
import 'package:you_search/src/network/youtube_data_source.dart';
import 'package:you_search/src/repository/youtube_search_repo.dart';

void initKiwi() {
  kiwi.KiwiContainer()
    ..registerInstance(http.Client())
    ..registerFactory((c) => YoutubeDataSource(c.resolve()))
    ..registerFactory((c) => YoutubeSearchRepo(c.resolve()))
    ..registerFactory((c) => YoutubeSearchBloc(c.resolve()));
}
