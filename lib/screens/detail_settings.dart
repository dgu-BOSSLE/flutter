import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'preview_screen_settings.dart';
import 'preview_before_applying.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';

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
      appBar: AppBar(title: Text('설정', style: GoogleFonts.notoSans(),),
        backgroundColor: SeedColors.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,  //수직으로 카드들 가운데 정렬 설정한 부분.
          children: [
            CustomCard(
              title: '바탕화면 선택',
              content: [
                ElevatedButton(onPressed: _pickImage, child: Text('갤러리', style: GoogleFonts.notoSans(color: Colors.black),), style: ElevatedButton.styleFrom(primary: SeedColors.primary),),
                SizedBox(width: 10.0),
                // ElevatedButton(onPressed: null, child: Text('현재 바탕화면')),
                SizedBox(width: 10.0), // 추가한 부분
                if (_selectedImage != null) ...[
                  Column( // 추가한 부분
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Image.file(_selectedImage!),
                              );
                            },
                          );
                        },
                        child: Text('사진 확인', style: GoogleFonts.notoSans(color: Colors.black),),
                        style: ElevatedButton.styleFrom(primary: SeedColors.primary),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            SizedBox(height: 9.0),
            CustomCard(title: '날씨 동기화', content: [
              Icon(Icons.sync_disabled, size: 30, color: Colors.redAccent, ),
              Switch(
                value: _sync_weather,
                onChanged: (value) {
                  setState(() {
                    _sync_weather = value;
                  });
                },
              ),
              Icon(Icons.sync, size: 30, color: Colors.greenAccent, ),
            ]),
            SizedBox(height: 9.0),
            CustomCard(title: '선택한 날씨만 활성화', content: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon_sunny.svg',
                    width: 40,
                    height: 40,
                  ),
                  Checkbox(
                    value: _sunny,
                    onChanged: (value) {
                      setState(() {
                        _sunny = value!;
                      });
                    },
                    activeColor: SeedColors.primary,
                    checkColor: Colors.black,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon_rainy.svg',
                    width: 40,
                    height: 40,
                  ),
                  Checkbox(
                    value: _rainy,
                    onChanged: (value) {
                      setState(() {
                        _rainy = value!;
                      });
                    },
                    activeColor: SeedColors.primary,
                    checkColor: Colors.black,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon_rainy_hard.svg',
                    width: 40,
                    height: 40,
                  ),
                  Checkbox(
                    value: _rainy_hard,
                    onChanged: (value) {
                      setState(() {
                        _rainy_hard = value!;
                      });
                    },
                    activeColor: SeedColors.primary,
                    checkColor: Colors.black,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon_snowy.svg',
                    width: 40,
                    height: 40,
                  ),
                  Checkbox(
                    value: _snowy,
                    onChanged: (value) {
                      setState(() {
                        _snowy = value!;
                      });
                    },
                    activeColor: SeedColors.primary,
                    checkColor: Colors.black,
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          color: SeedColors.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                child: Text('날씨 조절'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PreviewScreenSettingsScreen(
                            imageFile:
                            _selectedImage)), //context로 이미지 전달하며 프리뷰로 이동!
                  );
                },
              ),
              TextButton(
                child: Text("다음으로"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PreviewBeforeApplyingScreen()), //context로 이미지 전달하며 프리뷰로 이동!
                  );
                },
              ),
            ],
          )
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      color: Colors.white,
      child:
      Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: SeedColors.font,
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: content,
              )
            ],
          ),
        ),
      ),
    );
  }
}