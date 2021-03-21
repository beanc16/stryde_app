// This is a basic Flutter integration test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

//import 'file:///C:/Users/cbean/Documents/Homework/MSJ/20-21%20(Fall)/Senior%20Research/Bean%20Senior%20Project%20-%20App/workout_buddy/lib/screens/loggedOut/main.dart' as app;
import 'file:///C:/Users/cbean/Documents/Homework/MSJ/20-21 (Fall)/Senior Research/Bean Senior Project - App/workout_buddy_web/lib/screens/loggedOut/main.dart' as app;
void main() => run(_testMain);

void _testMain() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    app.main();

    // Trigger a frame.
    await tester.pumpAndSettle();

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}