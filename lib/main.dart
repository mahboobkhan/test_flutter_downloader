import 'package:downloader/downloading/DownloadedFilesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/start_screens/splash.dart';

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
      home: const SplashScreen(),
    );
  }
}

/*
*
  dataLog.data?.itemInfo?.itemStruct?.video?.bitrateInfo
            ?.forEach((bitrate) {
          print(
              'video H: ${bitrate.playAddr?.height}, video W: ${bitrate.playAddr?.width}');
          bitrate.playAddr?.urlList?.forEach((urlList) {
            print('video uriList: ${urlList}');
          });
        });
**/
