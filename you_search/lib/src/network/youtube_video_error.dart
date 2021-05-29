import 'dart:core';

class YoutubeVideoError implements Exception {
  final String message;

  YoutubeVideoError(this.message);
}
