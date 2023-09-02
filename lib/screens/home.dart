import 'package:flutter/material.dart';
import 'detail_settings.dart';
import 'preset_list.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

const seedColor = Color(0xFFC8A2C8);
const outPadding = 32.0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: MaterialColor(seedColor.value, {
          50: seedColor.withOpacity(0.1),
          100: seedColor.withOpacity(0.2),
          200: seedColor.withOpacity(0.3),
          300: seedColor.withOpacity(0.4),
          400: seedColor.withOpacity(0.5),
          500: seedColor.withOpacity(0.6),
          600: seedColor.withOpacity(0.7),
          700: seedColor.withOpacity(0.8),
          800: seedColor.withOpacity(0.9),
          900: seedColor.withOpacity(1.0),
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end, // 변경된 부분
        children: <Widget>[
          Spacer(),
          Image.asset('assets/Bossle.png', fit: BoxFit.cover), // 추가된 부분
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailSettingsScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: seedColor,
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: outPadding, vertical: 15),
            ),
            child: Text('바탕화면 세부설정 및 바꾸기'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PresetListScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: seedColor,
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: outPadding, vertical: 15),
            ),
            child: Text('내 프리셋'),
          ),
          SizedBox(height: 50), // 추가된 부분
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
            Image.asset('assets/Bossle.png', fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
