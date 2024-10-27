import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app/main_app/ScreenDownloaded.dart';
import 'app/main_app/ServerScreen.dart';
import 'app/main_app/ScreenProgress.dart';
import 'app/main_app/TickTokScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('VID_Lab'),
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
            TikTokScreen(), // First Tab
            ScreenDownloaded(), // Second Tab
            ScreenProgress(), // Third Tab
          ],
        ),
      ),
    );
  }
}
