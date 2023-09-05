import 'package:flutter/material.dart';

const seedColor = Color(0xFFA3DAFF);

class PresetListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preset List Screen'),
        backgroundColor: seedColor,
      ),
      body: Center(
        child: Text('Preset List Screen'),
      ),
    );
  }
}
