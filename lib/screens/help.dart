import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Call on Time in Background'),
        ),
        body: ApiCallOnTime(),
      ),
    );
  }
}

class ApiCallOnTime extends StatefulWidget {
  @override
  _ApiCallOnTimeState createState() => _ApiCallOnTimeState();
}

class _ApiCallOnTimeState extends State<ApiCallOnTime> {
  String _apiResponse = 'API Call on Time in Background';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(minutes: 15), (timer) => callApi());
  }

  Future<void> callApi() async {
    final response = await http.get(Uri.parse('https://helpp.free.beeceptor.com/todos'));

    if (response.statusCode == 200) {
      print('API call success: ${response.body}');
    } else {
      print('API call failed: ${response.statusCode}');
    }
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_apiResponse),
    );
  }
}

void main() {
  runApp(MyApp());
}
