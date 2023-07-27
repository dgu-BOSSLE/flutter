import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BackgroundScreen(),
    );
  }
}

class BackgroundScreen extends StatelessWidget {
  final String websiteUrl = 'https://ptluaan.github.io/-raindrop_effect/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Website as Background'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(websiteUrl)),
        onWebViewCreated: (controller) {
          // WebView가 준비되면 콘텐츠를 배경화면으로 설정합니다.
          controller.evaluateJavascript(source: '''
            // JavaScript 코드를 여기에 넣어서 콘텐츠를 수정하거나 추가할 수 있습니다.
            // 예를 들어 배경화면을 전체 화면으로 확대하거나 이미지를 가운데로 정렬하는 등의 작업을 수행할 수 있습니다.
          ''');
        },
      ),
    );
  }
}
