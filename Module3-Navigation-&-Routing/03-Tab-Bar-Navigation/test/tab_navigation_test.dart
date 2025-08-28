import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tab_navigation_examples/examples/basic_tabs_example.dart';
import 'package:flutter_tab_navigation_examples/examples/manual_tabs_example.dart';
import 'package:flutter_tab_navigation_examples/examples/nested_scroll_tabs_example.dart';

void main() {
  group('Tab Navigation Tests', () {
    group('Basic Tabs Example Tests', () {
      testWidgets('should display all three tabs', (tester) async {
        await tester.pumpWidget(const BasicTabsExample());

        // Verify all tabs are present
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Search'), findsOneWidget);
        expect(find.text('Profile'), findsOneWidget);
      });

      testWidgets('should show home tab content initially', (tester) async {
        await tester.pumpWidget(const BasicTabsExample());

        // Verify home tab content is displayed
        expect(find.text('Home Tab'), findsOneWidget);
        expect(find.text('Featured Item'), findsOneWidget);
      });

      testWidgets('should switch to search tab when tapped', (tester) async {
        await tester.pumpWidget(const BasicTabsExample());

        // Tap on search tab
        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();

        // Verify search tab content is displayed
        expect(find.text('Search Tab'), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);
      });

      testWidgets('should switch to profile tab when tapped', (tester) async {
        await tester.pumpWidget(const BasicTabsExample());

        // Tap on profile tab
        await tester.tap(find.text('Profile'));
        await tester.pumpAndSettle();

        // Verify profile tab content is displayed
        expect(find.text('Profile Tab'), findsOneWidget);
        expect(find.text('John Doe'), findsOneWidget);
      });

      testWidgets('should handle tab interactions', (tester) async {
        await tester.pumpWidget(const BasicTabsExample());

        // Tap on featured item
        await tester.tap(find.text('Featured Item'));
        await tester.pumpAndSettle();

        // Verify snackbar appears
        expect(find.text('Featured item tapped!'), findsOneWidget);
      });
    });

    group('Manual TabController Example Tests', () {
      testWidgets('should display all four tabs', (tester) async {
        await tester.pumpWidget(const ManualTabsExample());

        // Verify all tabs are present
        expect(find.text('Dashboard'), findsOneWidget);
        expect(find.text('Messages'), findsOneWidget);
        expect(find.text('Favorites'), findsOneWidget);
        expect(find.text('Settings'), findsOneWidget);
      });

      testWidgets('should show dashboard tab content initially', (tester) async {
        await tester.pumpWidget(const ManualTabsExample());

        // Verify dashboard tab content is displayed
        expect(find.text('Dashboard Tab'), findsOneWidget);
        expect(find.text('Add More Items'), findsOneWidget);
      });

      testWidgets('should preserve state when switching tabs', (tester) async {
        await tester.pumpWidget(const ManualTabsExample());

        // Add more items in dashboard
        await tester.tap(find.text('Add More Items'));
        await tester.pumpAndSettle();

        // Switch to messages tab
        await tester.tap(find.text('Messages'));
        await tester.pumpAndSettle();

        // Switch back to dashboard
        await tester.tap(find.text('Dashboard'));
        await tester.pumpAndSettle();

        // Verify dashboard still shows the updated content
        expect(find.text('Dashboard Tab'), findsOneWidget);
      });

      testWidgets('should clear unread count when visiting messages tab', (tester) async {
        await tester.pumpWidget(const ManualTabsExample());

        // Initially should have unread count badge
        expect(find.text('5'), findsOneWidget);

        // Tap on messages tab
        await tester.tap(find.text('Messages'));
        await tester.pumpAndSettle();

        // Unread count should be cleared
        expect(find.text('0'), findsOneWidget);
      });

      testWidgets('should handle programmatic tab switching', (tester) async {
        await tester.pumpWidget(const ManualTabsExample());

        // Tap the swap button to programmatically switch tabs
        await tester.tap(find.byIcon(Icons.swap_horiz));
        await tester.pumpAndSettle();

        // Should now be on the next tab (Messages)
        expect(find.text('Messages Tab'), findsOneWidget);
      });

      testWidgets('should handle floating action button', (tester) async {
        await tester.pumpWidget(const ManualTabsExample());

        // Tap floating action button
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        // Verify snackbar appears
        expect(find.text('Added 3 new messages. Total: 8'), findsOneWidget);
      });
    });

    group('NestedScrollView Tabs Example Tests', () {
      testWidgets('should display all three tabs', (tester) async {
        await tester.pumpWidget(const NestedScrollTabsExample());

        // Verify all tabs are present
        expect(find.text('Articles'), findsOneWidget);
        expect(find.text('Photos'), findsOneWidget);
        expect(find.text('Videos'), findsOneWidget);
      });

      testWidgets('should show articles tab content initially', (tester) async {
        await tester.pumpWidget(const NestedScrollTabsExample());

        // Verify articles tab content is displayed
        expect(find.text('Article 1'), findsOneWidget);
        expect(find.text('Read More'), findsOneWidget);
      });

      testWidgets('should switch to photos tab when tapped', (tester) async {
        await tester.pumpWidget(const NestedScrollTabsExample());

        // Tap on photos tab
        await tester.tap(find.text('Photos'));
        await tester.pumpAndSettle();

        // Verify photos tab content is displayed
        expect(find.text('Photo 1'), findsOneWidget);
      });

      testWidgets('should switch to videos tab when tapped', (tester) async {
        await tester.pumpWidget(const NestedScrollTabsExample());

        // Tap on videos tab
        await tester.tap(find.text('Videos'));
        await tester.pumpAndSettle();

        // Verify videos tab content is displayed
        expect(find.text('Video 1'), findsOneWidget);
        expect(find.text('Play'), findsOneWidget);
      });

      testWidgets('should handle nested scrolling', (tester) async {
        await tester.pumpWidget(const NestedScrollTabsExample());

        // Scroll down in the articles tab
        await tester.drag(find.byType(ListView), const Offset(0, -500));
        await tester.pumpAndSettle();

        // Should still be able to see the tab bar
        expect(find.text('Articles'), findsOneWidget);
      });
    });

    group('Accessibility Tests', () {
      testWidgets('should have proper semantic labels', (tester) async {
        await tester.pumpWidget(const BasicTabsExample());

        // Verify tabs have semantic labels
        expect(find.bySemanticsLabel('Home'), findsOneWidget);
        expect(find.bySemanticsLabel('Search'), findsOneWidget);
        expect(find.bySemanticsLabel('Profile'), findsOneWidget);
      });

      testWidgets('should support screen readers', (tester) async {
        await tester.pumpWidget(const ManualTabsExample());

        // Verify tab content is accessible
        expect(find.text('Dashboard Tab'), findsOneWidget);
        expect(find.text('Add More Items'), findsOneWidget);
      });
    });

    group('Responsive Design Tests', () {
      testWidgets('should handle scrollable tabs', (tester) async {
        await tester.pumpWidget(const BasicTabsExample());

        // Verify tabs are scrollable
        final tabBar = tester.widget<TabBar>(find.byType(TabBar));
        expect(tabBar.isScrollable, isTrue);
      });

      testWidgets('should work with different screen sizes', (tester) async {
        // Test with a smaller screen size
        tester.view.physicalSize = const Size(320, 568);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(const BasicTabsExample());

        // Verify tabs still work on small screen
        expect(find.text('Home'), findsOneWidget);
        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();
        expect(find.text('Search Tab'), findsOneWidget);

        // Reset window size
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });

    group('Performance Tests', () {
      testWidgets('should handle many list items efficiently', (tester) async {
        await tester.pumpWidget(const ManualTabsExample());

        // Add many items to test performance
        for (int i = 0; i < 5; i++) {
          await tester.tap(find.text('Add More Items'));
          await tester.pumpAndSettle();
        }

        // Should still be responsive
        expect(find.text('Dashboard Tab'), findsOneWidget);
      });

      testWidgets('should dispose controllers properly', (tester) async {
        await tester.pumpWidget(const ManualTabsExample());

        // Navigate away and back to test disposal
        await tester.pumpWidget(const MaterialApp(home: Scaffold()));
        await tester.pumpWidget(const ManualTabsExample());

        // Should still work after disposal and recreation
        expect(find.text('Dashboard Tab'), findsOneWidget);
      });
    });
  });
}
