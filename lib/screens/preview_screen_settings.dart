import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PreviewScreenSettingsScreen extends StatefulWidget {
  final File? imageFile;
  final String websiteUrl = 'https://fe82-61-72-189-152.ngrok-free.app/';

  PreviewScreenSettingsScreen({required this.imageFile});

  @override
  _PreviewScreenSettingsScreenState createState() => _PreviewScreenSettingsScreenState();
}

class _PreviewScreenSettingsScreenState extends State<PreviewScreenSettingsScreen> {
  double _sliderValue = 50;
  late InAppWebViewController _webViewController;  // 웹뷰 컨트롤러를 선언

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
                _webViewController = controller;  // 웹뷰 컨트롤러 초기화
                controller.evaluateJavascript(source: '''
  function onSliderValueChanged(value) {
    if (window.effectCanvas && window.effectCanvas.dropletManager && typeof window.effectCanvas.dropletManager.setIntensity === "function") {
      window.effectCanvas.dropletManager.setIntensity(value);
    }
  }
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
                      // 슬라이더 값이 변경될 때마다 웹뷰의 onSliderValueChanged 함수 호출
                      _webViewController.evaluateJavascript(source: 'setGlobalDropletIntensity($_sliderValue);');

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
