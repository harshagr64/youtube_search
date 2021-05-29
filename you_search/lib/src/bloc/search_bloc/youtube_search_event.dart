part of 'youtube_search_bloc.dart';

abstract class YoutubeSearchEvent extends Equatable {
  const YoutubeSearchEvent();

  @override
  List<Object> get props => [];
}

class FetchSerachData extends YoutubeSearchEvent {
  final String query;

  FetchSerachData(this.query);

  @override
  List<Object> get props => [query];
}

class FetchNextSerachData extends YoutubeSearchEvent {
  @override
  List<Object> get props => [];
}
