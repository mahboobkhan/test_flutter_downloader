import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../downloading/DownloadProvider.dart';
import '../../downloading/VideoInfoProvider.dart';
import '../items/VideoInfo.dart';

class ScreenMain extends StatelessWidget {
  final TextEditingController urlController = TextEditingController(
      text: 'https://www.youtube.com/watch?v=AkL9d2BEs3A');

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoInfoProvider()),
        ChangeNotifierProvider(create: (_) => DownloadProvider()),
      ],
      child: Scaffold(
        body: Consumer2<VideoInfoProvider, DownloadProvider>(
          builder: (context, videoInfoProvider, downloadProvider, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: urlController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Video URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    videoInfoProvider.fetchVideoInfo(urlController.text);
                  },
                  child: const Text('Fetch Video Info'),
                ),
                Expanded(
                  child: _buildStateContent(
                      context, videoInfoProvider, downloadProvider),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStateContent(BuildContext context, VideoInfoProvider provider,
      DownloadProvider downloadProvider) {
    switch (provider.state) {
      case VideoInfoState.loading:
        return const Center(child: CircularProgressIndicator());
      case VideoInfoState.success:
        return _buildVideoInfo(context, provider.videoInfo!, downloadProvider);
      case VideoInfoState.error:
        return Center(
          child: Text(
            'Error: ${provider.errorMessage}',
            style: const TextStyle(color: Colors.red),
          ),
        );
      default:
        return const Center(child: Text('Enter a URL and fetch video info'));
    }
  }

  Widget _buildVideoInfo(BuildContext context, VideoInfo videoInfo,
      DownloadProvider downloadProvider) {
    return ListView.builder(
      itemCount: videoInfo.formats.length,
      itemBuilder: (BuildContext context, int index) {
        bool isDownloading = downloadProvider.downloadingIndex == index;
        bool isAnotherDownloading = downloadProvider.downloadingIndex != null &&
            downloadProvider.downloadingIndex != index;

        return ListTile(
          leading: videoInfo.thumbnail == "N/A"
              ? const Icon(Icons.edit)
              : Image.network(
                  videoInfo.formats[index]['url'],
                  fit: BoxFit.cover,
                ),
          title: Text('($index) ${videoInfo.title}'),
          subtitle: Text(
              '${videoInfo.formats[index]['vcodec']} / ${videoInfo.formats[index]['acodec']} / ${videoInfo.formats[index]['ext']}'),
          trailing: ElevatedButton(
            onPressed: isAnotherDownloading
                ? null
                : () {
                    downloadProvider.downloadFile(
                        videoInfo.formats[index]['url'],
                        videoInfo.title,
                        index);
                  },
            child: isDownloading
                ? Text('Downloading ${downloadProvider.progress}')
                : Text('Download'),
          ),
        );
      },
    );
  }
}

/*
*
*
*   showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<DownloadProvider>(
            builder: (context, downloadProvider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    downloadProvider.isDownloading
                        ? 'Downloading $title...'
                        : 'Download Complete!',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: downloadProvider.isDownloading
                        ? (double.tryParse(downloadProvider.progress
                                    .replaceAll('%', '')) ??
                                0) /
                            100
                        : 1.0, // Show 1.0 when complete
                  ),
                  const SizedBox(height: 16),
                  Text('Progress: ${downloadProvider.progress}'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: downloadProvider.isPaused
                            ? () => downloadProvider.resumeDownload(url, title)
                            : () => downloadProvider.pauseDownload(),
                        child: Text(
                            downloadProvider.isPaused ? 'Resume' : 'Pause'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          downloadProvider.cancelDownload();
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
*
*
*
*
*
*
* */
