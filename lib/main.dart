import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wallpaper Manager Example'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text('Set Wallpaper'),
            onPressed: () async {
              String assetPath = 'assets/rain.jpg';
              ByteData data = await rootBundle.load(assetPath);
              List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
              String dir = (await getTemporaryDirectory()).path;
              String path = '$dir/temp.jpg';
              File tempFile = File(path);
              await tempFile.writeAsBytes(bytes);

              try {
                final bool homeResult = await WallpaperManager.setWallpaperFromFile(
                  path, WallpaperManager.HOME_SCREEN,
                );
                final bool lockResult = await WallpaperManager.setWallpaperFromFile(
                  path, WallpaperManager.LOCK_SCREEN,
                );
                if(homeResult && lockResult){
                  debugPrint("Wallpaper set successfully on both screens");
                } else {
                  debugPrint("unable to be set");
                }
              } on PlatformException {
                debugPrint("Wallpaper could not be set");
              }
            },
          ),
        ),
      ),
    );
  }
}
