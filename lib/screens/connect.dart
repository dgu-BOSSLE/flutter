import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather Info App'),
        ),
        body: WeatherInfoScreen(),
      ),
    );
  }
}

class WeatherInfoScreen extends StatefulWidget {
  @override
  _WeatherInfoScreenState createState() => _WeatherInfoScreenState();
}

class _WeatherInfoScreenState extends State<WeatherInfoScreen> {
  String _response = '';

  Future<void> _getWeatherInfo() async {
    var request = http.Request('POST',
        Uri.parse('https://uvloi234ok.execute-api.ap-northeast-2.amazonaws.com/Prod/weather-info'));
    request.body = '''{
    "latitude": 37.613693710852104,
    "longitude": 126.83651750476827
    }''';

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setState(() async {
        _response = await response.stream.bytesToString();
      });
    }
    else {
      setState(() {
        _response = response.reasonPhrase!;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: _getWeatherInfo,
            child: Text('Get Weather Info'),
          ),
          Text(_response),
        ],
      ),
    );
  }

}
