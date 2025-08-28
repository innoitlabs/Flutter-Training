import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_navigation_drawer_tutorial/main.dart';

void main() {
  testWidgets('App starts and shows tutorial home page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NavigationDrawerTutorialApp());

    // Verify that the app title is displayed
    expect(find.text('Navigation Drawer Tutorial'), findsOneWidget);
    
    // Verify that the main tutorial title is displayed
    expect(find.text('Flutter Navigation Drawer (Material 3)'), findsOneWidget);
    
    // Verify that the three example cards are displayed
    expect(find.text('Classic Drawer (Modal)'), findsOneWidget);
    expect(find.text('Named Routes + Selected State'), findsOneWidget);
    expect(find.text('Material 3 NavigationDrawer + Adaptive Rail'), findsOneWidget);
  });

  testWidgets('Classic drawer example can be navigated to', (WidgetTester tester) async {
    await tester.pumpWidget(const NavigationDrawerTutorialApp());

    // Tap the classic drawer example card
    await tester.tap(find.text('Classic Drawer (Modal)'));
    await tester.pumpAndSettle();

    // Verify we're on the classic drawer example page
    expect(find.text('Classic Drawer Example'), findsOneWidget);
    expect(find.text('Swipe from left edge or tap the menu button'), findsOneWidget);
  });

  testWidgets('Named routes example can be navigated to', (WidgetTester tester) async {
    await tester.pumpWidget(const NavigationDrawerTutorialApp());

    // Tap the named routes example card
    await tester.tap(find.text('Named Routes + Selected State'));
    await tester.pumpAndSettle();

    // Verify we're on the named routes example page
    expect(find.text('Named Routes Example'), findsOneWidget);
    expect(find.text('Named Routes with Selected State'), findsOneWidget);
  });

  testWidgets('Material 3 drawer example can be navigated to', (WidgetTester tester) async {
    await tester.pumpWidget(const NavigationDrawerTutorialApp());

    // Tap the Material 3 drawer example card
    await tester.tap(find.text('Material 3 NavigationDrawer + Adaptive Rail'));
    await tester.pumpAndSettle();

    // Verify we're on the Material 3 drawer example page
    expect(find.text('Material 3 NavigationDrawer'), findsOneWidget);
    expect(find.text('Resize the window to see adaptive behavior'), findsOneWidget);
  });
}
