import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenProgress extends StatefulWidget {
  @override
  _ScreenProgressState createState() => _ScreenProgressState();
}

class _ScreenProgressState extends State<ScreenProgress> {
  int progress = 0;

  void updateProgress(int newProgress) {
    setState(() {
      progress = newProgress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Download Progress: $progress%'),
          LinearProgressIndicator(value: progress / 100),
        ],
      ),
    );
  }
}
