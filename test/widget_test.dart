import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picture/main.dart'; // Replace with your app's import

void main() {
  testWidgets('Main screen should have "Set Wallpaper" button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our button is present.
    expect(find.widgetWithText(ElevatedButton, 'Set Wallpaper'), findsOneWidget);
  });
}
