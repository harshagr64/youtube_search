part of 'youtube_search_bloc.dart';

abstract class YoutubeSearchState extends Equatable {
  const YoutubeSearchState();

  @override
  List<Object> get props => [];
}

class YoutubeSearchInitial extends YoutubeSearchState {
  bool hasReachedEndofResults;
  YoutubeSearchInitial(
    this.hasReachedEndofResults,
  );

  @override
  // TODO: implement props
  List<Object> get props => [hasReachedEndofResults];
}

class YoutubeSearchLoading extends YoutubeSearchState {
  bool hasReachedEndofResults;
  YoutubeSearchLoading(
    this.hasReachedEndofResults,
  );

  @override
  // TODO: implement props
  List<Object> get props => [hasReachedEndofResults];
}

class YoutubeSearchFailure extends YoutubeSearchState {
  final String error;
  bool hasReachedEndofResults;

  YoutubeSearchFailure(
    this.error,
    this.hasReachedEndofResults,
  );

  @override
  List<Object> get props => [error, hasReachedEndofResults];
}

class YoutubeSearchSuccess extends YoutubeSearchState {
  final List<Item> searchResult;
  bool hasReachedEndofResults;

  YoutubeSearchSuccess(
    this.searchResult,
    this.hasReachedEndofResults,
  );

  @override
  List<Object> get props => [searchResult, hasReachedEndofResults];
}
