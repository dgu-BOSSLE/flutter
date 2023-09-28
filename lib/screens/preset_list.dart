import 'package:flutter/material.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gallery_saver/gallery_saver.dart';
import '../colors.dart';

const seedColor = Color(0xFFA3DAFF);

class PresetListScreen extends StatelessWidget {
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
