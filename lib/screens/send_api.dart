import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class APiApp extends StatelessWidget {
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
    final now = DateTime.now();
    final startTime = DateTime(now.year, now.month, now.day, 16,0);
    final endTime = DateTime(now.year, now.month, now.day, 16,40);

    if (now.isAfter(startTime) && now.isBefore(endTime)) {
      final response = await http.get(Uri.parse('https://helpp.free.beeceptor.com/todos'));

      if (response.statusCode == 200) {
        print('API call success: ${response.body}');
      } else {
        print('API call failed: ${response.statusCode}');
      }
    } else {
      print('Not time to call API yet');
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
