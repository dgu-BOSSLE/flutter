import 'dart:io';
import 'package:flutter/material.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gallery_saver/gallery_saver.dart';
import '../colors.dart';

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

  Future<void> saveToGallery(BuildContext context) async {
    final byteData = await rootBundle.load('assets/raw/cat.mp4');

    final extDir = await getExternalStorageDirectory();
    final file = await File('${extDir?.path}/cat.mp4').create(recursive: true);

    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    GallerySaver.saveVideo(file.path).then((bool? success) {
      String result = success == true ? "비디오 저장 성공!" : "비디오 저장 실패.";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SeedColors.primary,
        title: Text('Live Wallpaper Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(SeedColors.primary)),
              onPressed: () async {
                String result;
                bool goToHome = true;
                try {
                  await requestPermission();
                  String filePath = await copyAssetToExternalStorage('assets/raw/cat.mp4', 'cat.mp4');

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
            SizedBox(height: 20),  // Adds some space between the buttons
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(SeedColors.primary)),
              onPressed: () {
                saveToGallery(context);
              },
              child: Text('Save to Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
