import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class PreviewBeforeApplyingScreen extends StatefulWidget {
  @override
  _PreviewBeforeApplyingScreenState createState() =>
      _PreviewBeforeApplyingScreenState();
}

class _PreviewBeforeApplyingScreenState
    extends State<PreviewBeforeApplyingScreen> {
  late InAppWebViewController _webViewController;
  final List<String> websiteUrls = [
    'https://graceful-souffle-034b9b.netlify.app',
    'https://graceful-souffle-034b9b.netlify.app',
    'https://graceful-souffle-034b9b.netlify.app',
  ];
  int currentIndex = 0;
  final List<String> randomMessages = [
    "배경화면 생성중...",
  ];

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
              '배경화면 만들기',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _webViewController.evaluateJavascript(
                    source: 'window.isButtonPressed = true;');
                _showRandomPopup();
              },
              child: Text('적용', style: TextStyle(fontSize: 16)),
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest:
                URLRequest(url: Uri.parse(websiteUrls[currentIndex])),
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
                onLoadStop: (controller, url) {
                  int currentFileIndex =
                      currentIndex; // Save the currentIndex before incrementing
                  controller.addJavaScriptHandler(
                      handlerName: "videoCreated",
                      callback: (args) {
                        _handleDownload(args[0], currentFileIndex);
                        if (currentIndex < websiteUrls.length - 1) {
                          currentIndex++;
                          controller.loadUrl(
                              urlRequest: URLRequest(
                                  url: Uri.parse(websiteUrls[currentIndex])));
                        }
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _showRandomPopup() {
  //   int randomIndex = Random().nextInt(randomMessages.length);
  //
  //   List<String> cuteGifs = [
  //     'https://media3.giphy.com/media/Gv8ssNe0ayE6JW9ZMB/giphy.gif?cid=ecf05e479lkslmdj7skebevo0nzdks4rj0u7y586kvlqx0bl&ep=v1_gifs_search&rid=giphy.gif&ct=g',
  //     'https://media2.giphy.com/media/YxA2PPkXbwRTa/giphy.gif?cid=ecf05e47q7trvnhs4wp5zcpfqsp7omptsv7kye0sj4kv0fqg&ep=v1_gifs_search&rid=giphy.gif&ct=g',
  //     'https://media4.giphy.com/media/JHCcEc9vLvHZS/giphy.gif?cid=ecf05e47qosjwh0etp1ixt5f0db4ed89bizze50f0ysxruee&ep=v1_gifs_search&rid=giphy.gif&ct=g',
  //     'https://media2.giphy.com/media/mnIjWW97Jn9mg/giphy.gif?cid=ecf05e47q789b5b2206gjovf9wjnkrqcyvkw5txxp45mvobf&ep=v1_gifs_search&rid=giphy.gif&ct=g',
  //     'https://media4.giphy.com/media/12oeJpFwY3zYwU/giphy.gif?cid=ecf05e479er7pzqtgh9o06p2oqb6ojmiecu9phg5aw1ehehe&ep=v1_gifs_search&rid=giphy.gif&ct=g',
  //     'https://media2.giphy.com/media/VxbvpfaTTo3le/giphy.gif?cid=ecf05e47sooruh9gqei0uef6s2m2chd7fuv3ly8iaw1djiq8&ep=v1_gifs_search&rid=giphy.gif&ct=g',
  //   ];
  //   int randomGifIndex = Random().nextInt(cuteGifs.length);
  //
  //   int counter = 10;
  //   Stream<int> timerStream = Stream.periodic(Duration(seconds: 1), (i) {
  //     return counter - i;
  //   }).take(counter);
  //
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       Future.delayed(Duration(seconds: 10), () {
  //         Navigator.of(context).pop();
  //       });
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20), // 팝업창 모서리 둥글게
  //         ),
  //         elevation: 16,
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 randomMessages[randomIndex],
  //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
  //               ),
  //               SizedBox(height: 20), // 텍스트와 움짤 사이 간격
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 10.0),
  //                 child: Image.network(cuteGifs[randomGifIndex], fit: BoxFit.cover),  // 귀여운 움짤에 패딩 추가
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  _showRandomPopup() {
    int randomIndex = Random().nextInt(randomMessages.length);
    List<String> cuteGifs = [
      'https://media3.giphy.com/media/Gv8ssNe0ayE6JW9ZMB/giphy.gif?cid=ecf05e479lkslmdj7skebevo0nzdks4rj0u7y586kvlqx0bl&ep=v1_gifs_search&rid=giphy.gif&ct=g',
      'https://media2.giphy.com/media/YxA2PPkXbwRTa/giphy.gif?cid=ecf05e47q7trvnhs4wp5zcpfqsp7omptsv7kye0sj4kv0fqg&ep=v1_gifs_search&rid=giphy.gif&ct=g',
      'https://media4.giphy.com/media/JHCcEc9vLvHZS/giphy.gif?cid=ecf05e47qosjwh0etp1ixt5f0db4ed89bizze50f0ysxruee&ep=v1_gifs_search&rid=giphy.gif&ct=g',
      'https://media2.giphy.com/media/mnIjWW97Jn9mg/giphy.gif?cid=ecf05e47q789b5b2206gjovf9wjnkrqcyvkw5txxp45mvobf&ep=v1_gifs_search&rid=giphy.gif&ct=g',
      'https://media4.giphy.com/media/12oeJpFwY3zYwU/giphy.gif?cid=ecf05e479er7pzqtgh9o06p2oqb6ojmiecu9phg5aw1ehehe&ep=v1_gifs_search&rid=giphy.gif&ct=g',
      'https://media2.giphy.com/media/VxbvpfaTTo3le/giphy.gif?cid=ecf05e47sooruh9gqei0uef6s2m2chd7fuv3ly8iaw1djiq8&ep=v1_gifs_search&rid=giphy.gif&ct=g',
    ];
    int randomGifIndex = Random().nextInt(cuteGifs.length);

    Timer? countdownTimer; // 타이머 변수 추가
    int counter = 9;
    StreamController<int> streamController = StreamController<int>();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StreamBuilder<int>(
          stream: streamController.stream,
          initialData: counter,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.data! <= 0) {
              return SizedBox.shrink();
            }

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          randomMessages[randomIndex],
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                        ),
                        SizedBox(width: 10),
                        Text(
                          snapshot.data.toString(),
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Image.network(cuteGifs[randomGifIndex], fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      countdownTimer?.cancel();
      streamController.close();
    });

    countdownTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (counter < 1) {
        timer.cancel();
        streamController.close();
        Navigator.of(context, rootNavigator: true).pop();  // 이 부분을 타이머 내부로 이동
      } else {
        if (!streamController.isClosed) {
          streamController.add(counter);
        }
        counter--;
      }
    });
  }


  Future<void> _handleDownload(String dataUri, int fileIndex) async {
    try {
      // Split the header from the rest of the URI
      final String encodedStr = dataUri.split(",")[1];

      // Decode the base64 encoded string
      final decodedBytes = base64Decode(encodedStr);

      var dir = await getApplicationDocumentsDirectory();
      var file = File('${dir.path}/rain$fileIndex.mp4');
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
