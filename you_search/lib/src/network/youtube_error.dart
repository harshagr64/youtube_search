import 'dart:core';

class YoutubeError implements Exception {
  final String message;

  YoutubeError(this.message);
}
