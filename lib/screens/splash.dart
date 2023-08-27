import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; //강제종료시 사용
import 'package:picture/screens/detail_settings.dart';
import 'home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_app_settings/open_app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    permissionCheck(context);
  }

  Future<void> permissionCheck(context) async{
    PermissionStatus storageStatus = await Permission.storage.status;
    PermissionStatus locationStatus = await Permission.location.status;
    if (storageStatus.isGranted && locationStatus.isGranted) {
      navigateHome(context);
    }
    else {
      Fluttertoast.showToast(msg: "앱 사용을 위한 권한에 동의해 주세요.");
      PermissionStatus storageRequest;
      do {
        storageRequest = await Permission.storage.request();
      } while (!storageRequest.isGranted);
      PermissionStatus locationRequest;
      do {
        locationRequest = await Permission.location.request();
      } while (!locationRequest.isGranted);
      navigateHome(context);
    }
  }

  // void overridePermission() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('권한이 거부되었습니다.'),
  //       content: Text('앱 사용을 위한 저장소 사용 권한에 동의해 주세요.'),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             // 앱 설정 화면으로 이동
  //             OpenAppSettings.openAppSettings();
  //             Navigator.of(context).pop();
  //           },
  //           child: Text('Open Settings'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<void> navigateHome(context) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('newuser') ?? true) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DetailSettingsScreen())
      );
    }
    else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashImage(),
    );
  }
}

class SplashImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/splash.png', // 이미지 파일 경로
          width: 300, // 이미지의 가로 크기
          height: 300, // 이미지의 세로 크기
        ),
      ),
    );
  }
}



