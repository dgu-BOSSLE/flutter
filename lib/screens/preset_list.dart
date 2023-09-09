import 'dart:io';
import 'package:flutter/material.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PresetListScreen extends StatelessWidget {
  Future<String> copyAssetToExternalStorage(String assetPath, String fileName) async {
    final byteData = await rootBundle.load(assetPath);

    final appDocDir = await getApplicationDocumentsDirectory();
    final file = await File('${appDocDir.path}/$fileName').create(recursive: true);

    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file.path;
  }

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isDenied) {
      // The user denied the permission
      throw Exception('Storage permission denied');
    }
    if (status.isPermanentlyDenied) {
      // The user denied the permission permanently. Open app settings to allow the user to enable it.
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Wallpaper Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String result;
            bool goToHome = true;

            try {
              await requestPermission();
              String filePath = await copyAssetToExternalStorage('assets/cat.mp4', 'cat.mp4');

              result = await AsyncWallpaper.setLiveWallpaper(
                filePath: filePath,
                goToHome: goToHome,
                toastDetails: ToastDetails.success(),
                errorToastDetails: ToastDetails.error(),
              )
                  ? 'Wallpaper set'
                  : 'Failed to get wallpaper.';
            } on PlatformException {
              result = 'Failed to get wallpaper.';
            }

            // Display the result in a dialog or console
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(result),
              ),
            );
          },
          child: Text('Set Live Wallpaper'),
        ),
      ),
    );
  }
}
