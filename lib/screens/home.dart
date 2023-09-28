import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'detail_settings.dart';
import 'preset_list.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';

void main() => runApp(MyApp());

const outPadding = 32.0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: MaterialColor(SeedColors.primary.value, {
          50: SeedColors.primary.withOpacity(0.1),
          100: SeedColors.primary.withOpacity(0.2),
          200: SeedColors.primary.withOpacity(0.3),
          300: SeedColors.primary.withOpacity(0.4),
          400: SeedColors.primary.withOpacity(0.5),
          500: SeedColors.primary.withOpacity(0.6),
          600: SeedColors.primary.withOpacity(0.7),
          700: SeedColors.primary.withOpacity(0.8),
          800: SeedColors.primary.withOpacity(0.9),
          900: SeedColors.primary.withOpacity(1.0),
        })),
      ).copyWith(
        textTheme: GoogleFonts.notoSansTextTheme(
          ThemeData.light().textTheme,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late InAppWebViewController _rainWebViewController;
  String _base64Image = '';

  @override
  void initState() {
    super.initState();
    loadImageAsBase64();
  }

  Future<void> loadImageAsBase64() async {
    ByteData bytes = await rootBundle.load('assets/home.jpg');
    var buffer = bytes.buffer;
    var m = base64.encode(Uint8List.view(buffer));
    setState(() {
      _base64Image = m;
      _rainWebViewController.evaluateJavascript(source: 'displayImage("$_base64Image");');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse('https://graceful-souffle-034b9b.netlify.app')),
            onWebViewCreated: ((controller) {
              _rainWebViewController = controller;
            }),
            onLoadStop: (controller, url) {
              controller.evaluateJavascript(source: 'setGlobalDropletIntensity(50);');
              controller.evaluateJavascript(source: 'displayImage("$_base64Image");');
            },
          ),
          Column(
            children: [
              Spacer(),
              Image.asset('assets/Bossle3.png', fit: BoxFit.cover), // 추가된 부분
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailSettingsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: SeedColors.primary,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: outPadding, vertical: 15),
                ),
                child: Text('바탕화면 세부설정 및 바꾸기'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PresetListScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: SeedColors.primary,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: outPadding, vertical: 15),
                ),
                child: Text('잠금화면으로 설정'),
              ),
              SizedBox(height: 80), // 추가된 부분
            ],
          ),
        ],
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Bossle3.png', fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
