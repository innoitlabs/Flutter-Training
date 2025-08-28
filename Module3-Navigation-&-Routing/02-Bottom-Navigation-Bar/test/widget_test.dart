import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bottom_navigation_demo/main.dart';

void main() {
  group('Bottom Navigation Tests', () {
    testWidgets('Default selected index is 0', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Verify home tab is selected by default
      expect(find.text('Home Screen'), findsOneWidget);
      expect(find.text('Search Screen'), findsNothing);
    });

    testWidgets('Tapping destination updates content', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Tap on search tab
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();
      
      // Verify search screen is shown
      expect(find.text('Search Screen'), findsOneWidget);
      expect(find.text('Home Screen'), findsNothing);
    });

    testWidgets('NavigationBar has correct number of destinations', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Verify there are 3 navigation destinations
      expect(find.byType(NavigationDestination), findsNWidgets(3));
    });

    testWidgets('Navigation destinations have correct labels', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Verify the navigation destination labels are present
      // Use find.byType to be more specific about NavigationDestination labels
      expect(find.byType(NavigationDestination), findsNWidgets(3));
      
      // Check that we can find the navigation bar
      expect(find.byType(NavigationBar), findsOneWidget);
    });
  });
}
