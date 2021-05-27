import 'package:you_search/src/data/data_model.dart';
import 'package:you_search/src/network/youtube_data_source.dart';

class YoutubeSearchRepo {
  final YoutubeDataSource _youtubeSearchData;

  String _lastSearchedQuery;
  String _nextPageToken;

  YoutubeSearchRepo(this._youtubeSearchData);

  Future<List<Item>> searchVideos(String query) async {
    final searchResult = await _youtubeSearchData.searchVideos(query: query);
    _cacheValues(
      query,
      searchResult.nextPageToken,
    );
    if (searchResult.items.isEmpty) {
      throw NoSearchResultsException();
    }
    return searchResult.items;
  }

  void _cacheValues(String query, String nextPageToken) {
    _lastSearchedQuery = query;
    _nextPageToken = nextPageToken;
  }

  Future<List<Item>> searchNextVideos() async {
    if (_lastSearchedQuery == null) {
      throw SearchNonInitiatedException();
    }
    if (_nextPageToken == null) {
      throw NoNextPageTokenException();
    }
    final nextSearchResult = await _youtubeSearchData.searchVideos(
      query: _lastSearchedQuery,
      nextPageToken: _nextPageToken,
    );
    _cacheValues(
      _lastSearchedQuery,
      nextSearchResult.nextPageToken,
    );

    return nextSearchResult.items;
  }
}

class NoNextPageTokenException implements Exception {
  // final message = '';
}

class SearchNonInitiatedException implements Exception {
  final message = 'Can not get next page result without searching first';
}

class NoSearchResultsException implements Exception {
  final message = 'No Results';
}
