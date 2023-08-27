import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
  final String SnowWebsiteUrl = 'https://7ce3-61-102-174-151.ngrok-free.app';
  final String RainWebsiteUrl = 'https://db22-61-72-189-152.ngrok-free.app';

  PreviewScreenSettingsScreen({required this.imageFile});

  @override
  _PreviewScreenSettingsScreenState createState() => _PreviewScreenSettingsScreenState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Screen Settings'),
      ),
      body: Stack(
        children: [
          if (_showSnowScreen) SnowPreview(
            snowWebsiteUrl: widget.SnowWebsiteUrl,
            sliderValue: _snowSliderValue,
            onWebViewCreated: (controller) {
              _snowWebViewController = controller;
            },
          ),
          if (_showRainScreen) RainPreview(
            rainWebsiteUrl: widget.RainWebsiteUrl,
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
              height: 200,
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
                                  min: 0.5,
                                  max: 3,
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

class SnowPreview extends StatelessWidget {
  final Function(InAppWebViewController) onWebViewCreated;
  final String snowWebsiteUrl;
  final double sliderValue;

  SnowPreview({required this.onWebViewCreated, required this.snowWebsiteUrl, required this.sliderValue});

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(snowWebsiteUrl)),
      onWebViewCreated: onWebViewCreated,
      onLoadStop: (controller, url) {
        controller.evaluateJavascript(source: 'setSnowDensity($sliderValue);');
      },
    );
  }
}

class RainPreview extends StatelessWidget {
  final Function(InAppWebViewController) onWebViewCreated;
  final String rainWebsiteUrl;
  final double sliderValue;

  RainPreview({required this.onWebViewCreated, required this.rainWebsiteUrl, required this.sliderValue});

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(rainWebsiteUrl)),
      onWebViewCreated: onWebViewCreated,
      onLoadStop: (controller, url) {
        controller.evaluateJavascript(source: 'setGlobalDropletIntensity($sliderValue);');
      },
    );
  }
}

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
