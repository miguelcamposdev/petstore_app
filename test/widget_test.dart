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

    // Verify that IncidentListScreen is shown (since it's the new initial route).
    expect(find.text('Incidencias'), findsOneWidget);
    expect(find.text('GESTIÓN'), findsOneWidget);

    // Verify FAB exists
    expect(find.byIcon(Icons.add), findsOneWidget);

    // We do not test further navigation since we haven't linked the FAB to AddIncidentScreen yet,
    // and the original test assumed HomeScreen was initialRoute.

    // Reset window size
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
