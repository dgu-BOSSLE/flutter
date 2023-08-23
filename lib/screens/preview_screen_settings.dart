import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PreviewScreenSettingsScreen extends StatefulWidget {
  final File? imageFile;
  final String websiteUrl = 'https://755a-61-72-189-152.ngrok-free.app/';

  PreviewScreenSettingsScreen({required this.imageFile});

  @override
  _PreviewScreenSettingsScreenState createState() => _PreviewScreenSettingsScreenState();
}

class _PreviewScreenSettingsScreenState extends State<PreviewScreenSettingsScreen> {
  double _sliderValue = 50;
  late InAppWebViewController _webViewController;
  ButtonStyle customButtonStyle(Color color) {
    return ElevatedButton.styleFrom(
      primary: color, // Button background color
      onPrimary: Colors.white, // Button text color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Button border radius
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Screen Settings'),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.websiteUrl)),
            onWebViewCreated: (controller) {
              _webViewController = controller;
              controller.evaluateJavascript(source: '''
  function onSliderValueChanged(value) {
    if (window.effectCanvas && window.effectCanvas.dropletManager && typeof window.effectCanvas.dropletManager.setIntensity === "function") {
      window.effectCanvas.dropletManager.setIntensity(value);
    }
  }
''');
            },
          ),
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
                  width: 0.3,  // You can adjust the width as needed
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
                          // Add your button's onPressed logic here
                        },
                        child: Text("Button 1"), // 텍스트 추가
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // Default blue color
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          // Add your button's onPressed logic here
                        },
                        child: Text("Button 2"), // 텍스트 추가
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // Default blue color
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          // Add your button's onPressed logic here
                        },
                        child: Text("Button 3"), // 텍스트 추가
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // Default blue color
                        ),
                      ),

                    ],
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
            ),
          ),
        ],
      ),
    );
  }

}

