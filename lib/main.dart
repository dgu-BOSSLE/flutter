import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';
import 'screens/send_api.dart';
import 'screens/globals.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalVariables.loadPreferences();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MainScreen(), //  MainScreen
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: HomeScreen()), // HomeScreen 위젯
          if(GlobalVariables.shouldCallApi ?? true) //나중에 false해야함.
            Expanded(child: ApiCallOnTime()), // ApiCallOnTime 위젯
        ],
      ),
    );
  }
}