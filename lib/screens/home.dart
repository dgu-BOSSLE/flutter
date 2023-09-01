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
              child: Text('바탕화면 세부설정 및 바꾸기'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PresetListScreen()),
                );
              },
              child: Text('내 프리셋'),
            ),
          ],
        ),
      ),
    );
  }
}
