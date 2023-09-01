import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workmanager/workmanager.dart';

void myTask() {
  callApi();
}

Future<void> callApi() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    print('API call success: ${response.body}');
  } else {
    print('API call failed: ${response.statusCode}');
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    myTask();
    return Future.value(true);
  });
}

void main() {
  runApp(MyApp());
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    '1',
    'simplePeriodicTask',
    frequency: Duration(minutes: 15),
  );
}

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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('API Call on Time in Background'),
    );
  }
}
