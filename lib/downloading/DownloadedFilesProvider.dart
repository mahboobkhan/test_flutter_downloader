import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class DownloadedFilesProvider with ChangeNotifier {
  List<FileSystemEntity> files = [];
  String directoryPath =
      '/storage/emulated/0/Android/data/com.example.downloader/files/';

  DownloadedFilesProvider() {
    _checkPermissionsAndListFiles();
  }

  Future<void> _checkPermissionsAndListFiles() async {
    // Request storage permissions
    var status = await Permission.videos.request();
    if (status.isGranted) {
      // List files in the directory
      _listFiles();
    } else {
      // Handle permission denied (this should be done in the UI)
      print('Storage permission is required to access files');
    }
  }

  void _listFiles() {
    Directory directory = Directory(directoryPath);
    files = directory.existsSync() ? directory.listSync() : [];
    notifyListeners();
  }

  Future<void> refreshFiles() async {
    _listFiles();
  }

  void deleteFile(FileSystemEntity file) {
    file.deleteSync();
    _listFiles(); // Update file list after deletion
    notifyListeners();
  }

  void renameFile(FileSystemEntity file, String newName) {
    String newFilePath = path.join(path.dirname(file.path), newName);
    file.renameSync(newFilePath);
    _listFiles(); // Update file list after renaming
    notifyListeners();
  }
}
