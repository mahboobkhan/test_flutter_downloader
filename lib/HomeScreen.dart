import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app/main_app/ScreenDownloaded.dart';
import 'app/main_app/ScreenMain.dart';
import 'app/main_app/ScreenProgress.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Video Downloader'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Downloads'),
              Tab(text: 'Progress'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ScreenMain(), // First Tab
            ScreenDownloaded(), // Second Tab
            ScreenProgress(), // Third Tab
          ],
        ),
      ),
    );
  }
}
