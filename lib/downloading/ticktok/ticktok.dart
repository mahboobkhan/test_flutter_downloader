import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

import 'TikTokModels.dart'; // For parsing HTML.

class TikTok {
  final String url;
  final bool cut;

  TikTok({required this.url, this.cut = false});

  // Function to fetch and process the content from TikTok
  Future<Map<String, dynamic>> fetchAndProcess() async {
    final headers = {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
      'Referer': 'https://www.tiktok.com/'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode != 200) {
        return {
          'error': true,
          'message': 'something went wrong',
          'error_message':
              'Failed to fetch page content: ${response.statusCode}'
        };
      }

      final document = parse(response.body);
      final scriptTag = document
          .querySelector('script[id="__UNIVERSAL_DATA_FOR_REHYDRATION__"]');

      if (scriptTag == null) {
        return {
          'error': true,
          'message': 'something went wrong',
          'error_message': 'No script tag found with the required ID.'
        };
      }

      final scriptContent = scriptTag.text.trim();

      final jsonData = jsonDecode(scriptContent);

      final webappVideoDetail =
          jsonData['__DEFAULT_SCOPE__']['webapp.video-detail'];
      if (webappVideoDetail == null) {
        return {
          'error': true,
          'message': 'something went wrong',
          'error_message': 'No "webapp.video-detail" found in the JSON data.'
        };
      }

      return {'data': webappVideoDetail};
    } catch (e) {
      return {
        'error': true,
        'message': 'something went wrong',
        'error_message': e.toString()
      };
    }
  }

  // Main function to get video data
  Future<Map<String, dynamic>> getVideos() async {
    final dataResponse = await fetchAndProcess();
    //  print("dataLoaded   $dataResponse");
    if (dataResponse['error'] == true) {
      return dataResponse;
    }

    // Log data for debugging

    if (cut) {
      try {
        Artist dataLog = Artist.fromJson(dataResponse);
        dataLog.data?.itemInfo?.itemStruct?.video?.bitrateInfo?.forEach((bitrate) {
          print('video H: ${bitrate.playAddr?.height}, video W: ${bitrate.playAddr?.width}');
          bitrate.playAddr?.urlList?.forEach((urlList) {
            print('video uriList: ${urlList}');
          });

        });

        return {
          'error': false,
          'data': dataResponse,
        };
      } catch (e) {
        return {
          'error': true,
          'message': 'something went wrong',
          'error_message': e.toString()
        };
      }
    }
    return dataResponse;
  }
}



void mainTickTok() async {
  final tiktok = TikTok(
    url: 'https://www.tiktok.com/@1_nabeel_10/video/7335045031255870725?q=image%20post&t=1728788961659',
    cut: true, // If you want to process the data further.
  );
  final videoData = await tiktok.getVideos();
  // print(videoData);
}



