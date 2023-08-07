import 'package:flutter/material.dart';
import 'preview_screen_settings.dart';

class DetailSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Settings Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PreviewScreenSettingsScreen()),
            );
          },
          child: Text('Go to Preview Screen Settings'),//프리뷰 내 사용자 설정
        ),
      ),
    );
  }
}
