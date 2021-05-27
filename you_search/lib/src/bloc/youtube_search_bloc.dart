import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:you_search/src/data/data_model.dart';
import 'package:you_search/src/network/youtube_error.dart';
import 'package:you_search/src/repository/youtube_search_repo.dart';

part 'youtube_search_event.dart';
part 'youtube_search_state.dart';

class YoutubeSearchBloc extends Bloc<YoutubeSearchEvent, YoutubeSearchState> {
  final YoutubeSearchRepo _youtubeSearchRepo;
  YoutubeSearchState _searchState = YoutubeSearchInitial(false);
  YoutubeSearchBloc(this._youtubeSearchRepo)
      : super(YoutubeSearchInitial(false));

  @override
  Stream<YoutubeSearchState> mapEventToState(
    YoutubeSearchEvent event,
  ) async* {
    if (event is FetchSerachData) {
      yield* mapEventInitiated(event);
    } else if (event is FetchNextSerachData) {
      yield* mapFetchNextResultPage();
    }
  }

  Stream<YoutubeSearchState> mapEventInitiated(
    FetchSerachData event,
  ) async* {
    if (event.query.isEmpty) {
      yield YoutubeSearchInitial(false);
      _searchState = YoutubeSearchInitial(false);
    } else {
      yield YoutubeSearchLoading(false);
      _searchState = YoutubeSearchLoading(false);
      try {
        final searchResult = await _youtubeSearchRepo.searchVideos(event.query);

        yield YoutubeSearchSuccess(searchResult, false);
        _searchState = YoutubeSearchSuccess(searchResult, false);
      } on YoutubeError catch (e) {
        yield YoutubeSearchFailure(e.message, false);
        _searchState = YoutubeSearchFailure(e.message, false);
      } on NoSearchResultsException catch (e) {
        yield YoutubeSearchFailure(e.message, false);
        _searchState = YoutubeSearchFailure(e.message, false);
      }
    }
  }

  Stream<YoutubeSearchState> mapFetchNextResultPage() async* {
    try {
      final searchNextResult = await _youtubeSearchRepo.searchNextVideos();
      final cs = _searchState;
      if (cs is YoutubeSearchSuccess) {
        yield YoutubeSearchSuccess(cs.searchResult + searchNextResult, false);
        _searchState =
            YoutubeSearchSuccess(cs.searchResult + searchNextResult, false);
      }
    } on NoNextPageTokenException catch (_) {
      final cs = _searchState;
      if (cs is YoutubeSearchInitial) {
        yield YoutubeSearchInitial(true);
        _searchState = YoutubeSearchInitial(cs.hasReachedEndofResults);
      } else if (cs is YoutubeSearchLoading) {
        yield YoutubeSearchLoading(true);
        _searchState = YoutubeSearchLoading(cs.hasReachedEndofResults);
      } else if (cs is YoutubeSearchSuccess) {
        yield YoutubeSearchSuccess(cs.searchResult, true);
        _searchState =
            YoutubeSearchSuccess(cs.searchResult, cs.hasReachedEndofResults);
      } else if (cs is YoutubeSearchFailure) {
        yield YoutubeSearchFailure(cs.error, true);
        _searchState =
            YoutubeSearchFailure(cs.error, cs.hasReachedEndofResults);
      }
    } on SearchNonInitiatedException catch (e) {
      yield YoutubeSearchFailure(e.message, false);
      _searchState = YoutubeSearchFailure(e.message, false);
    } on YoutubeError catch (e) {
      yield YoutubeSearchFailure(e.message, false);
      _searchState = YoutubeSearchFailure(e.message, false);
    }
  }
}
