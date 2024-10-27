import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;


const String apiBaseUrl = 'https://api16-normal-v4.tiktokv.com';
const Map<String, String> headers = {
  'User-Agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
};

Future<String> get(String url) async {
  final response = await http.get(Uri.parse(url), headers: headers);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Uint8List> getBuffer(String url,
    {Function(DownloadProgress)? progress}) async {
  final request = await http.Client()
      .send(http.Request('GET', Uri.parse(url))..headers.addAll(headers));
  final total = request.contentLength ?? 0;
  int downloaded = 0;
  List<int> data = [];

  await for (var chunk in request.stream) {
    data.addAll(chunk);
    downloaded += chunk.length;
    if (progress != null) {
      progress(DownloadProgress(
          downloaded: downloaded,
          total: total,
          progress: (downloaded / total) * 100));
    }
  }

  return Uint8List.fromList(data);
}

Future<String> getFullURL(String url) async {
  final regex = RegExp(r'(vm|vt|www)\.tiktok\.com\/(.*)');
  if (!regex.hasMatch(url)) {
    throw Exception('Unknown TikTok video URL: $url');
  }

  final response = await http.get(Uri.parse(url), headers: headers);
  if (response.isRedirect && response.headers['location'] != null) {
    return response.headers['location']!;
  } else {
    throw Exception('No redirect found');
  }
}

String getVideoId(String url) {
  final regex = RegExp(r'\/video\/(\d*)');
  final match = regex.firstMatch(url);
  if (match != null) {
    return match.group(1)!;
  } else {
    throw Exception('Invalid TikTok video URL: $url');
  }
}

Future<String> detectVideoId(String url) async {
  if (url.contains(RegExp(r'(vm|vt|www)\.tiktok\.com\/'))) {
    url = await getFullURL(url);
  }
  return getVideoId(url);
}

Future<TikTokVideo> fetchVideo(String video) async {
  video = video.trim();
  final videoId =
      video.contains(RegExp(r'^\d*$')) ? video : await detectVideoId(video);
  final url = '$apiBaseUrl/aweme/v1/feed/?aweme_id=$videoId';
  final data = await get(url);
  final json = jsonDecode(data);
  final videoData = json['aweme_list'][0];

  final videoWatermark = TikTokVideoSource(
    uri: videoData['video']['download_addr']['uri'],
    url: videoData['video']['download_addr']['url_list'][0],
    width: videoData['video']['download_addr']['width'],
    height: videoData['video']['download_addr']['height'],
    dataSize: videoData['video']['download_addr']['data_size'],
  );

  final videoNoWatermark = TikTokVideoSource(
    uri: videoData['video']['play_addr']['uri'],
    url: videoData['video']['play_addr']['url_list'][0],
    width: videoData['video']['play_addr']['width'],
    height: videoData['video']['play_addr']['height'],
    dataSize: videoData['video']['play_addr']['data_size'],
  );

  final music = TikTokMusic(
    id: videoData['music']['id'],
    name: videoData['music']['title'],
    author: videoData['music']['author'],
    url: videoData['music']['play_url']['url_list'][0],
  );

  return TikTokVideo(
    id: videoData['aweme_id'],
    url:
        'https://www.tiktok.com/@${videoData['author']['nickname']}/video/${videoData['aweme_id']}',
    description: videoData['desc'],
    author: videoData['author']['nickname'],
    videoWatermark: videoWatermark,
    videoNoWatermark: videoNoWatermark,
    width: videoData['video']['width'],
    height: videoData['video']['height'],
    likes: videoData['statistics']['digg_count'],
    shares: videoData['statistics']['share_count'],
    playCount: videoData['statistics']['play_count'],
    comments: videoData['statistics']['comment_count'],
    music: music,
    previewImageUrl: videoData['video']['origin_cover']['url_list'][0],
  );
}

class TikTokVideo {
  final String id;
  final String url;
  final String description;
  final String author;
  final TikTokVideoSource videoWatermark;
  final TikTokVideoSource videoNoWatermark;
  final int width;
  final int height;
  final int likes;
  final int shares;
  final int playCount;
  final int comments;
  final TikTokMusic music;
  final String previewImageUrl;

  TikTokVideo({
    required this.id,
    required this.url,
    required this.description,
    required this.author,
    required this.videoWatermark,
    required this.videoNoWatermark,
    required this.width,
    required this.height,
    required this.likes,
    required this.shares,
    required this.playCount,
    required this.comments,
    required this.music,
    required this.previewImageUrl,
  });
}

class TikTokVideoSource {
  final String uri;
  final String url;
  final int width;
  final int height;
  final int dataSize;

  TikTokVideoSource({
    required this.uri,
    required this.url,
    required this.width,
    required this.height,
    required this.dataSize,
  });
}

class TikTokMusic {
  final String id;
  final String name;
  final String author;
  final String url;

  TikTokMusic({
    required this.id,
    required this.name,
    required this.author,
    required this.url,
  });
}

class DownloadProgress {
  final int total;
  final int downloaded;
  final double progress;

  DownloadProgress(
      {required this.total, required this.downloaded, required this.progress});
}
