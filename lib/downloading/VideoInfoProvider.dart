import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../app/items/VideoInfo.dart';

enum VideoInfoState { initial, loading, success, error }


class VideoInfoProvider with ChangeNotifier {
  VideoInfoState _state = VideoInfoState.initial;
  VideoInfoState get state => _state;

  VideoInfo? _videoInfo;
  VideoInfo? get videoInfo => _videoInfo;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  // Method to fetch video information
  Future<void> fetchVideoInfo(String url) async {
    _state = VideoInfoState.loading;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://192.168.10.6:5000/download'),//http://192.168.10.6:5000
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"url": url}),
      );

      if (response.statusCode == 200) {
        _videoInfo = VideoInfo.fromJson(jsonDecode(response.body));
        print("all videos ${_videoInfo?.formats.length}");
        _state = VideoInfoState.success;
      } else {
        _errorMessage = 'Failed to load video info';
        _state = VideoInfoState.error;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _state = VideoInfoState.error;
    } finally {
      notifyListeners();
    }
  }

  void reset() {
    _state = VideoInfoState.initial;
    _videoInfo = null;
    _errorMessage = '';
    notifyListeners();
  }
}
