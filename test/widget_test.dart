// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:percentage/main.dart';

void main() {
  testWidgets('Test Home Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify UI.
    expect(find.text('Please enter a value'), findsOneWidget);
    expect(find.text('Total Amount'), findsOneWidget);

    // Tap the on the percentage toggle button
    await tester.enterText(find.byType(TextField), '500');
    await tester.tap(find.byType(ToggleButtons));

    await tester.tap(find.text('Calculate Tip'));
    await tester.pump();

    // Verify that the text has been dismissed.
    expect(find.text('Please enter a value'), findsNothing);
  });
}
