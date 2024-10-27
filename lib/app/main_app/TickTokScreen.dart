import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../downloading/DownloadProvider.dart';
import '../../downloading/ticktok/TikTokModels.dart';
import '../../downloading/ticktok/ticktok.dart';

class TikTokScreen extends StatelessWidget {
  final TextEditingController urlController = TextEditingController(
    text:
        'https://www.tiktok.com/@goldstatus81/video/7428545900710006023?_r=1&_t=8qtZi3tsEvX',
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
          final videos = getVideos(tiktokProvider.result!);

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
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: videos?.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Height: ${videos?[index].playAddr?.height}, Width: ${videos?[index].playAddr?.width}'),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: videos?[index]
                                                    .playAddr
                                                    ?.urlList
                                                    ?.map((url) =>
                                                        Text('URL: $url'))
                                                    .toList() ??
                                                [],
                                          ),
                                          const Divider(),
                                        ],
                                      );
                                    },
                                  ),
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

List<BitrateInfo>? getVideos(Data _result) {
  _result?.itemInfo?.itemStruct?.video?.bitrateInfo?.forEach((bitrate) {
    print(
        'video H: ${bitrate.playAddr?.height}, video W: ${bitrate.playAddr?.width}');
    bitrate.playAddr?.urlList?.forEach((urlList) {
      print('video uriList: $urlList');
    });
  });

  return _result?.itemInfo?.itemStruct?.video?.bitrateInfo;
}
