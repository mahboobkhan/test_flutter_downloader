import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

import 'TikTokModels.dart'; // For parsing HTML.
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
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
          jsonData['user-post-item']['user-post-item'];
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
    print("dataLoaded   $dataResponse");
    if (dataResponse['error'] == true) {
      return dataResponse;
    }

    // Log data for debugging


      try {

        String data = dataResponse["data"];
        print("NowProfile $data");
        // final jsonData = jsonDecode(scriptContent);


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
}






Future<void> fetchTikTokProfile() async {
  final url = 'https://www.tiktok.com/@rumi._.edit'; // The TikTok profile URL
  final headers = {
    'User-Agent':
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
    'Referer': 'https://www.tiktok.com/'
  };

  try {
    // Fetch the HTML content from the URL
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      // Parse the HTML document
      var document = html.parse(response.body);

      // Find the user-post-item-list (you may need to adjust the selector based on the actual HTML structure)
      var postItems = document.querySelectorAll('.css-1uqux2o-DivItemContainerV2');

      for (var postItem in postItems) {
        // Extract the video URL from the <a> tag
        var videoLink = postItem.querySelector('a')?.attributes['href'];
        // Extract the description (or any other info you want) from the <img> tag's alt attribute
        var description = postItem.querySelector('img')?.attributes['alt'];

        // Print the extracted data
        if (videoLink != null && description != null) {
          print('Video URL: $videoLink');
          print('Description: $description');
          print('---');
        }
      }
    } else {
      print('Failed to load TikTok profile. Status code: ${response.statusCode}');

    }
  } catch (e) {
    print('Error: $e');
  }
}

void mainprofile() {
  fetchTikTokProfile();
}


