import 'package:flutter/material.dart';
import 'detail_settings.dart';
import 'preset_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailSettingsScreen()),
                );
              },
              child: Text('Go to Detail Settings'), //(바탕화면 바꾸기)세부설정
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PresetListScreen()),
                );
              },
              child: Text('Go to Preset List'), //내프리셋
            ),
          ],
        ),
      ),
    );
  }
}
