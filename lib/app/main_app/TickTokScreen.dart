import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../downloading/DownloadProvider.dart';
import '../../downloading/ticktok/ticktok.dart';

class TikTokScreen extends StatelessWidget {
  final TextEditingController urlController = TextEditingController(
    text:
        'https://www.tiktok.com/@1_nabeel_10/video/7335045031255870725?q=image%20post&t=1728788961659',
  );

  TikTokScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TikTokProvider()),
        ChangeNotifierProvider(create: (_) => DownloadProvider()),
      ],
      child: Scaffold(
        body: Consumer2<TikTokProvider, DownloadProvider>(
            builder: (context, tiktokProvider, downloaderProvider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    labelText: 'Enter video URL...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Center(
                child: tiktokProvider.isLoading
                    ? const CircularProgressIndicator()
                    : tiktokProvider.error != null
                        ? Text("Error: ${tiktokProvider.error}")
                        : tiktokProvider.result != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Video data loaded"),
                                  Text(
                                      "Artist name: ${tiktokProvider.result?.itemInfo}"),
                                  // Display additional Artist details as needed
                                ],
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  final url = urlController.text;
                                  tiktokProvider.fetchVideoData(url);
                                },
                                child: const Text("Fetch video data"),
                              ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

/*class TikTokScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("TikTok Video Data")),
      body:
    );
  }
}*/
