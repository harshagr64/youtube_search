import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:you_search/src/network/youtube_video_error.dart';
import 'package:you_search/src/repository/youtube_search_repo.dart';
import 'package:you_search/src/data/video_data_model.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final YoutubeSearchRepo _youtubeSearchRepo;
  DetailBloc(this._youtubeSearchRepo) : super(DetailInitial());

  @override
  Stream<DetailState> mapEventToState(
    DetailEvent event,
  ) async* {
    if (event is FetchDetails) {
      yield DetailLoading();

      try {
        final data = await _youtubeSearchRepo.searchSingleVideo(event.id);
        yield DetailSuccess(data);
      } on YoutubeVideoError catch (e) {
        yield DetailFailure(e.message);
      } on NoSuchVideoException catch(e){
        yield DetailFailure(e.message);
      }
    }
  }
}
