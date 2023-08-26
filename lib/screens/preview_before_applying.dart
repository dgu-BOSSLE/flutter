import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:convert';

class PreviewBeforeApplyingScreen extends StatefulWidget {
  @override
  _PreviewBeforeApplyingScreenState createState() => _PreviewBeforeApplyingScreenState();
}

class _PreviewBeforeApplyingScreenState extends State<PreviewBeforeApplyingScreen> {
  late InAppWebViewController _webViewController;
  final String websiteUrl = 'https://9573-61-72-189-152.ngrok-free.app/';

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermissions();
  }

  _checkAndRequestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is the Apply Screen',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _webViewController.evaluateJavascript(source: 'window.isButtonPressed = true;');
              },
              child: Text('적용', style: TextStyle(fontSize: 16)),
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(websiteUrl)),
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
                onLoadStop: (controller, url) {
                  controller.addJavaScriptHandler(
                      handlerName: "videoCreated",
                      callback: (args) {
                        _handleDownload(args[0]);
                      }
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleDownload(String dataUri) async {
    try {
      // Split the header from the rest of the URI
      final String encodedStr = dataUri.split(",")[1];

      // Decode the base64 encoded string
      final decodedBytes = base64Decode(encodedStr);

      var dir = await getApplicationDocumentsDirectory();
      var file = File('${dir.path}/rain.mp4');
      await file.writeAsBytes(decodedBytes);

      print("File saved at ${file.path}");

      // Show a simple alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('알림'),
            content: Text('배경화면이 저장되었습니다!'),
            actions: [
              TextButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

    } catch (e) {
      print("Error: $e");
    }
  }



}
