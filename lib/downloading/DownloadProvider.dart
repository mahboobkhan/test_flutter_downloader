import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DownloadProvider with ChangeNotifier {
  bool isDownloading = false;
  bool isPaused = false;
  String progress = '0%';
  CancelToken? cancelToken; // Used to pause or cancel download
  Dio dio = Dio(); // Dio instance

  // Start the download
  Future<void> downloadFile(String url, String title) async {
    if (isDownloading) {
      print("A download is already in progress.");
      return;
    }

    try {
      // Reset the downloading state to start fresh
      isDownloading = true;
      isPaused = false;
      progress = '0%';
      print("Starting download: $url");

      notifyListeners(); // Notify the listeners that download started

      // Get the app's directory to save the file
      Directory? appDocDir = await getExternalStorageDirectory();
      String savePath = '${appDocDir?.path}/$title.mp4'; // Adjust extension if needed

      // Initialize CancelToken to control the request
      cancelToken = CancelToken();

      // Download the file using Dio
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            // Update progress
            progress = "${(received / total * 100).toStringAsFixed(0)}%";
            print("Progress: $progress");
            notifyListeners(); // Notify listeners of the progress update
          }
        },
        cancelToken: cancelToken,
        options: Options(
          headers: {
            'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36',
            'Referer': 'https://www.tiktok.com/',
          },
        ),
      );

      // Mark download as completed
      isDownloading = false;
      progress = "Download complete";
      print("Download complete: $title");
      notifyListeners(); // Notify listeners when download completes
    } catch (exception) {
      print("Download error: $exception");
      isDownloading = false;
      progress = '0%'; // Reset progress on error
      notifyListeners(); // Notify listeners on download error
    }
  }

  // Reset download to allow starting again
  void resetDownload() {
    isDownloading = false;
    progress = '0%';
    isPaused = false;
    cancelToken = null;
    notifyListeners();
  }

  // Pause the download
  void pauseDownload() {
    if (isDownloading && !isPaused && cancelToken != null) {
      cancelToken!.cancel("Download paused");
      isPaused = true;
      print("Download paused");
      notifyListeners();
    }
  }

  // Resume the download
  Future<void> resumeDownload(String url, String title) async {
    if (isPaused) {
      isPaused = false;
      print("Resuming download...");
      downloadFile(url, title); // Re-initiate the download
    }
  }

  // Cancel the download completely
  void cancelDownload() {
    if (isDownloading && cancelToken != null) {
      cancelToken!.cancel("Download canceled");
      isDownloading = false;
      isPaused = false;
      print("Download canceled");
      notifyListeners();
    }
  }
}
