import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petstore_app/main.dart';

void main() {
  testWidgets('App navigation smoke test', (WidgetTester tester) async {
    // Set a larger screen size to ensure widgets are visible
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that RoomManagementScreen is shown.
    expect(find.text('Habitaciones'), findsOneWidget);

    // Reset window size
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
