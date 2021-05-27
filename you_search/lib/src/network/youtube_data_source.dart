import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:you_search/src/data/data_model.dart';
import 'package:you_search/src/network/api_key.dart';
import 'package:you_search/src/network/youtube_error.dart';

const int maxResult = 5;

// class used to handle HTTP request for fetching result of search made by the user
class YoutubeDataSource {
  final http.Client client;

  final String _searchBaseUrl =
      'https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=$maxResult&type=video&key=${ApiKey.API_KEY}';

  YoutubeDataSource(this.client);

  Future<DataModel> searchVideos({
    String query,
    String nextPageToken = '',
  }) async {
    final rawUrl = _searchBaseUrl +
        '&q=$query' +
        (nextPageToken.isNotEmpty ? '&pageToken=$nextPageToken' : '');

    final encodedUrl = Uri.encodeFull(rawUrl);

    final response = await client.get(encodedUrl);

    if (response.statusCode == 200) {
      DataModel data = dataModelFromJson(response.body);
      return data;
    } else {
      throw YoutubeError(json.decode(response.body)['error']['message']);
    }
  }
}
