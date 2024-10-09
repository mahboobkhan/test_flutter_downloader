import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path; // To handle file paths

class ScreenDownloaded extends StatefulWidget {
  @override
  _ScreenDownloadedState createState() => _ScreenDownloadedState();
}

class _ScreenDownloadedState extends State<ScreenDownloaded> {
  List<FileSystemEntity> files = [];
  String directoryPath =
      '/storage/emulated/0/Android/data/com.example.downloader/files/';

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndListFiles();
  }

  Future<void> _checkPermissionsAndListFiles() async {
    // Request storage permissions
    var status = await Permission.videos.request();
    if (status.isGranted) {
      // List files in the directory
      _listFiles();
    } else {
      // Handle permission denied
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Storage permission is required to access files')),
      );
    }
  }

  void _listFiles() {
    Directory directory = Directory(directoryPath);
    setState(() {
      files = directory.listSync(); // List all files
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: files.isEmpty
          ? const Center(child: Text('No files found'))
          : ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                FileSystemEntity file = files[index];
                print("files Downloaded $file ");
                String fileName = file.path.split('/').last; // Get file name

                return ListTile(
                  title: Text(fileName),
                  onTap: () => _openFile(file.path),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () =>
                            _renameFile(context, file), // Rename file function
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            _deleteFile(context, file), // Delete file function
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  void _openFile(String filePath) async {
    OpenFile.open(filePath);
  }

  void _deleteFile(BuildContext context, FileSystemEntity file) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete ${path.basename(file.path)}'),
          content: Text('Are you sure you want to delete this file?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                file.deleteSync();
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('File deleted')));
              },
            ),
          ],
        );
      },
    );
  }

  void _renameFile(BuildContext context, FileSystemEntity file) async {
    TextEditingController renameController = TextEditingController();
    String newName = '';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rename ${path.basename(file.path)}'),
          content: TextField(
            controller: renameController,
            decoration: InputDecoration(labelText: 'New name'),
            onChanged: (value) {
              newName = value;
            },
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Rename'),
              onPressed: () {
                if (newName.isNotEmpty) {
                  // Perform rename
                  String newFilePath =
                      path.join(path.dirname(file.path), newName);
                  file.renameSync(newFilePath);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Renamed to $newName')));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
