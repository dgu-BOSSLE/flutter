import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preview Screen App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PreviewScreenSettingsScreen(imageFile: null),
    );
  }
}

class PreviewScreenSettingsScreen extends StatefulWidget {
  final File? imageFile;
  final String SnowWebsiteUrl = 'https://resilient-bienenstitch-cfe484.netlify.app';
  final String RainWebsiteUrl = 'https://graceful-souffle-034b9b.netlify.app';
  PreviewScreenSettingsScreen({required this.imageFile});

  @override
  _PreviewScreenSettingsScreenState createState() =>
      _PreviewScreenSettingsScreenState();
}

class _PreviewScreenSettingsScreenState extends State<PreviewScreenSettingsScreen> {
  double _rainSliderValue = 50;
  double _snowSliderValue = 50;
  double _snowSpeedValue = 1;
  late InAppWebViewController _snowWebViewController;
  late InAppWebViewController _rainWebViewController;
  bool _showSnowScreen = false;
  bool _showRainScreen = false;
  bool _showSunScreen = false;
  String base64Image = "";

  @override
  Widget build(BuildContext context) {
    if (widget.imageFile != null) {
      base64Image = base64Encode(widget.imageFile!.readAsBytesSync());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Screen Settings'),
      ),
      body: Stack(
        children: [
          if (_showSnowScreen) SnowPreview(
            snowWebsiteUrl: widget.SnowWebsiteUrl,
            sliderValue: _snowSliderValue,
            base64Image: base64Image,
            onWebViewCreated: (controller) {
              _snowWebViewController = controller;
            },
          ),
          if (_showRainScreen) RainPreview(
            rainWebsiteUrl: widget.RainWebsiteUrl,
            base64Image: base64Image,
            sliderValue: _rainSliderValue,
            onWebViewCreated: (controller) {
              _rainWebViewController = controller;
            },
          ),
          if (_showSunScreen) SunPreview(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 0.3,
                ),
              ),
              height: 230, // Adjusted height to fit the new button
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showSnowScreen = false;
                            _showRainScreen = true;
                            _showSunScreen = false;
                          });
                        },
                        child: Text("비 화면"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showSnowScreen = true;
                            _showRainScreen = false;
                            _showSunScreen = false;
                          });
                        },
                        child: Text("눈 화면"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showSnowScreen = false;
                            _showRainScreen = false;
                            _showSunScreen = true;
                          });
                        },
                        child: Text("햇빛 화면"),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            snowValue: _snowSliderValue,
                            rainValue: _rainSliderValue,
                            snowSpeed: _snowSpeedValue,
                            base64Image: base64Image,
                          ),
                        ),
                      );
                    },
                    child: Text("결과값 확인하기"),
                  ),
                  if (_showRainScreen)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('0%'),
                          Expanded(
                            child: Slider(
                              value: _rainSliderValue,
                              onChanged: (value) {
                                setState(() {
                                  _rainSliderValue = value;
                                });
                                _rainWebViewController.evaluateJavascript(source: 'setGlobalDropletIntensity($_rainSliderValue);');
                              },
                              min: 0,
                              max: 100,
                              divisions: 100,
                              label: '${_rainSliderValue.round()}%',
                            ),
                          ),
                          Text('100%'),
                        ],
                      ),
                    ),
                  if (_showSnowScreen)
                    Column(
                      children: [
                        // 눈 양 조절 슬라이더
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.blue,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text('눈 갯수 0%', style: TextStyle(color: Colors.white)),
                              ),
                              Expanded(
                                child: Slider(
                                  value: _snowSliderValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _snowSliderValue = value;
                                    });
                                    _snowWebViewController.evaluateJavascript(source: 'setSnowDensity($_snowSliderValue);');
                                  },
                                  min: 0,
                                  max: 200,
                                  divisions: 100,
                                  label: '${_snowSliderValue.round()}%',
                                ),
                              ),
                              Container(
                                color: Colors.blue,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text('100%', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        // 눈 속도 조절 슬라이더
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.blue,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text('눈 속도 0%', style: TextStyle(color: Colors.white)),
                              ),
                              Expanded(
                                child: Slider(
                                  value: _snowSpeedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _snowSpeedValue = value;
                                    });
                                    _snowWebViewController.evaluateJavascript(source: 'setSnowFallSpeed($_snowSpeedValue);');
                                  },
                                  min: 0.2,
                                  max: 2,
                                  divisions: 100,
                                  label: '${_snowSpeedValue.round()}%',
                                ),
                              ),
                              Container(
                                color: Colors.blue,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text('100%', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 결과값 보려고 만든겁니다. -> 나중에 로직 추가하거나 지우기..?
class ResultScreen extends StatelessWidget {
  final double snowValue;
  final double rainValue;
  final double snowSpeed;
  final String base64Image;

  ResultScreen({required this.snowValue, required this.rainValue, required this.snowSpeed, required this.base64Image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Result Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Snow Value: $snowValue"),
            Text("Rain Value: $rainValue"),
            Text("Snow Speed: $snowSpeed"),
            Image.memory(base64Decode(base64Image)),
          ],
        ),
      ),
    );
  }
}

class SnowPreview extends StatelessWidget {
  final Function(InAppWebViewController) onWebViewCreated;
  final String snowWebsiteUrl;
  final double sliderValue;
  final String base64Image;

  SnowPreview({required this.onWebViewCreated, required this.snowWebsiteUrl, required this.sliderValue, required this.base64Image,});

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(snowWebsiteUrl)),
      onWebViewCreated: onWebViewCreated,
      onLoadStop: (controller, url) {
        controller.evaluateJavascript(source: 'setSnowDensity($sliderValue);');
        controller.evaluateJavascript(source: 'displayImage("$base64Image");');
      },
    );
  }
}

class RainPreview extends StatelessWidget {
  final Function(InAppWebViewController) onWebViewCreated;
  final String rainWebsiteUrl;
  final double sliderValue;
  final String base64Image;

  RainPreview({required this.onWebViewCreated, required this.rainWebsiteUrl, required this.sliderValue, required this.base64Image,});

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(rainWebsiteUrl)),
      onWebViewCreated: onWebViewCreated,
      onLoadStop: (controller, url) {
        controller.evaluateJavascript(source: 'setGlobalDropletIntensity($sliderValue);');
        controller.evaluateJavascript(source: 'displayImage("$base64Image");');
      },
    );
  }
}

// 나중에 햇빛 로직 추가하기
class SunPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow.withOpacity(0.8),
      child: Center(
        child: Text('햇빛 화면'),
      ),
    );
  }
}
