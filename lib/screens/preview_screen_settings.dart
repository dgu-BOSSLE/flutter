import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PreviewScreenSettingsScreen extends StatefulWidget {
  final File? imageFile;
  final String websiteUrl = 'https://f29f-61-72-189-152.ngrok-free.app/';

  PreviewScreenSettingsScreen({required this.imageFile});

  @override
  _PreviewScreenSettingsScreenState createState() => _PreviewScreenSettingsScreenState();
}

class _PreviewScreenSettingsScreenState extends State<PreviewScreenSettingsScreen> {
  double _sliderValue = 50; // 초기 슬라이더의 값은 50으로 설정

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Screen Settings'),
      ),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(widget.websiteUrl)),
              onWebViewCreated: (controller) {
                controller.evaluateJavascript(source: '''
                  // JavaScript 코드를 여기에 넣어서 콘텐츠를 수정하거나 추가할 수 있습니다.
                  // 예를 들어 배경화면을 전체 화면으로 확대하거나 이미지를 가운데로 정렬하는 등의 작업을 수행할 수 있습니다.
                ''');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('0%'),
                Expanded(
                  child: Slider(
                    value: _sliderValue,
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '${_sliderValue.round()}%',
                  ),
                ),
                Text('100%'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
