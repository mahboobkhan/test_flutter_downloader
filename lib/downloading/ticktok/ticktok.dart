import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'TikTokModels.dart'; // For parsing HTML.
import 'package:flutter/material.dart';

class TikTokProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Data? _result;

  Data? get result => _result;

  String? _error;

  String? get error => _error;

  Future<void> fetchVideoData(String url) async {
    _isLoading = true;
    _error = null;
    _result = null; // Clear previous result
    notifyListeners();

    final headers = {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
      'Referer': 'https://www.tiktok.com/'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode != 200) {
        _error = 'Failed to fetch page content: ${response.statusCode}';
      } else {
        final document = parse(response.body);
        final scriptTag = document
            .querySelector('script[id="__UNIVERSAL_DATA_FOR_REHYDRATION__"]');

        if (scriptTag == null) {
          _error = 'No script tag found with the required ID.';
        } else {
          final scriptContent = scriptTag.text.trim();

          final jsonData = jsonDecode(scriptContent);
          final webappVideoDetail =
              jsonData['__DEFAULT_SCOPE__']['webapp.video-detail'];

          if (webappVideoDetail == null) {
            _error = 'No "webapp.video-detail" found in the JSON data.';
          } else {
            print('video webappVideoDetail: $webappVideoDetail}');
            Data data = Data.fromJson(webappVideoDetail);
            _result = data;
            data?.itemInfo?.itemStruct?.video?.bitrateInfo?.forEach((bitrate) {
              print(
                  'video H: ${bitrate.playAddr?.height}, video W: ${bitrate.playAddr?.width}');
              bitrate.playAddr?.urlList?.forEach((urlList) {
                print('video uriList: $urlList');
              });
            });
          }
        }
      }
    } catch (e) {
      _error = 'Error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
