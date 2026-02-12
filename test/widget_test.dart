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

    // Verify that HomeScreen is shown.
    expect(find.text('Find Your Friend'), findsOneWidget);
    expect(find.text('Adopt a pet today!'), findsOneWidget);

    // Verify FAB exists
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Tap the '+' icon to go to AddPetScreen.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify AddPetScreen is shown.
    expect(find.text('Add New Pet'), findsOneWidget);
    expect(find.text('GENERAL INFO'), findsOneWidget);

    // Go back
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify we are back at HomeScreen
    expect(find.text('Find Your Friend'), findsOneWidget);

    // Find the pet card for 'Cooper'
    final cooperFinder = find.text('Cooper');

    // Scroll until it is visible (in case it is still off screen)
    await tester.ensureVisible(cooperFinder);

    expect(cooperFinder, findsOneWidget);
    await tester.tap(cooperFinder);
    await tester.pumpAndSettle();

    // Verify PetDetailScreen is shown.
    expect(find.text('Buddy'), findsOneWidget);
    expect(find.text('Adopt Buddy'), findsOneWidget);

    // Reset window size
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
