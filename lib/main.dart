import 'package:downloader/downloading/DownloadedFilesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomeScreen.dart';
import 'downloading/DownloadProvider.dart';
import 'downloading/VideoInfoProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DownloadedFilesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VidLab',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
