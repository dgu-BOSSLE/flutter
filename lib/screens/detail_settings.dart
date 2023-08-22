import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'preview_screen_settings.dart';
import 'preview_before_applying.dart';
class DetailSettingsScreen extends StatefulWidget {
  @override
  _DetailSettingsScreenState createState() => _DetailSettingsScreenState();
}

class _DetailSettingsScreenState extends State<DetailSettingsScreen> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Settings Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 200,
              ),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select an Image from Gallery'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreviewScreenSettingsScreen(imageFile: _selectedImage)),
                );
              },
              child: Text('Go to Preview Screen Settings'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreviewBeforeApplyingScreen()),
                );
              },
              child: Text('Go to  Preview Before Applying'),
            ),
          ],
        ),
      ),
    );
  }
}
