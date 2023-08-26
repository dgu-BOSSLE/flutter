import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'preview_screen_settings.dart';
import 'preview_before_applying.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailSettingsScreen extends StatefulWidget {
  @override
  _DetailSettingsState createState() => _DetailSettingsState();
}

class _DetailSettingsState extends State<DetailSettingsScreen> {
  File? _selectedImage;
  bool _sync_weather = true;
  bool _sunny = true;
  bool _rainy = true;
  bool _rainy_hard = true;
  bool _snowy = true;

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
      appBar: AppBar(title: Text('설정')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomCard(title: '바탕화면 선택', content: [
              if (_selectedImage != null)
                Image.file(
                  _selectedImage!,
                  height: 200,
                ),
              ElevatedButton(onPressed: _pickImage, child: Text('갤러리')),
              ElevatedButton(onPressed: null, child: Text('현재 바탕화면')),
            ]),
            SizedBox(height: 16.0),

            CustomCard(title: '날씨 동기화', content: [
              Text('안함'),
              Switch(
                value: _sync_weather,
                onChanged: (value) {
                  setState(() {
                    _sync_weather = value;
                  });
                },
              ),
              Text('동기화'),
            ]),
            SizedBox(height: 16.0),

            CustomCard(title: '선택한 날씨만 활성화', content: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  SvgPicture.asset('assets/icons/icon_sunny.svg',
                    width: 40, height: 40,
                  ),
                  Checkbox(
                    value: _sunny,
                    onChanged: (value) {
                      setState(() {
                        _sunny = value!;
                      });
                    },
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  SvgPicture.asset('assets/icons/icon_rainy.svg',
                    width: 40, height: 40,
                  ),
                  Checkbox(
                    value: _rainy,
                    onChanged: (value) {
                      setState(() {
                        _rainy = value!;
                      });
                    },
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  SvgPicture.asset('assets/icons/icon_rainy_hard.svg',
                    width: 40, height: 40,
                  ),
                  Checkbox(
                    value: _rainy_hard,
                    onChanged: (value) {
                      setState(() {
                        _rainy_hard = value!;
                      });
                    },
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  SvgPicture.asset('assets/icons/icon_snowy.svg',
                    width: 40, height: 40,
                  ),
                  Checkbox(
                    value: _snowy,
                    onChanged: (value) {
                      setState(() {
                        _snowy = value!;
                      });
                    },
                  ),
                ],
              ),
            ]),
            SizedBox(height: 16.0),

            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PreviewScreenSettingsScreen(imageFile: _selectedImage)),  //context로 이미지 전달하며 프리뷰로 이동!
              );
            }, child: Text('효과 설정 미리보기')),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final List<Widget> content;

  const CustomCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: content,
            )
          ],

        ),
      ),
    );
  }
}
