import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreviewScreenSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('효과 설정 미리보기(앱바 삭제 예정)'),
      ),
      body:
      ElevatedButton(onPressed: () {
        Navigator.pop(context);
        _showAlertDialog(context);
        _oldUserUpdate();
      }, child: Text('적용')),
    );
  }

  Future<void> _oldUserUpdate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('newuser', false);
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('적용 완료'),
          content: Text('적용 완료!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog 닫기
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
