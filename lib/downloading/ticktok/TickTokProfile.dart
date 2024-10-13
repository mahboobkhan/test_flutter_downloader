import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;
// Function to fetch user profile page


// Function to parse video URLs from the TikTok page
Future<List<String>> scrapeTikTokUserVideos(String username) async {
  final baseUrl = 'https://www.tiktok.com/$username';
  final headers = {
    'User-Agent':
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
    'Accept-Language': 'en-US,en;q=0.9',
  };

  try {
    final response = await http.get(Uri.parse(baseUrl), headers: headers);

    if (response.statusCode == 200) {
      // Parse the HTML content
      dom.Document document = parse(response.body);

      // Extract all video URLs that match the pattern
      final videoUrls = document
          .querySelectorAll('a[href^="/$username/video/"]') // Find all anchors with the specific video link
          .map((e) => 'https://www.tiktok.com${e.attributes['href']}')
          .toList();

      print("object $videoUrls");
      return videoUrls;
    } else {
      return Future.error(
          'Failed to load user profile. Status code: ${response.statusCode}');
    }
  } catch (e) {
    return Future.error('Error: $e');
  }
}



