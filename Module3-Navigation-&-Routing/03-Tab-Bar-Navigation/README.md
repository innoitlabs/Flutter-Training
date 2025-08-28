# Flutter Tab Bar Navigation (Material 3)

## Learning Objectives

By the end of this module, you will be able to:

1. **Understand Navigation Patterns**: Know when to use tabbed navigation versus bottom navigation, navigation rail, or drawer navigation
2. **Implement Tab Navigation**: Build tabs using DefaultTabController + TabBar + TabBarView with proper state management
3. **Manage Tab Controllers**: Use manual TabController for fine-grained control and lifecycle management
4. **Preserve Tab State**: Implement state preservation techniques to maintain scroll positions and content state
5. **Create Advanced Tabs**: Build collapsing/scrolling tabs using NestedScrollView and SliverAppBar
6. **Style and Theme**: Apply Material 3 theming and ensure accessibility compliance

## Concepts & Best Practices

### When to Use Tabs vs Other Navigation

- **Tabs**: Use for peer sections within the same context (e.g., different views of the same data, related content categories)
- **Bottom Navigation**: Use for app-level destinations (e.g., Home, Search, Profile)
- **Navigation Rail**: Use for larger screens (tablets, desktop) with more space
- **Drawer**: Use for secondary navigation options and settings

### Tab Anatomy

- **TabBar**: The horizontal strip containing tab buttons
- **TabBarView**: The container that displays the content for each tab
- **TabController**: Manages the state and coordinates between TabBar and TabBarView

### DefaultTabController vs Manual TabController

- **DefaultTabController**: Simple, automatic state management for basic use cases
- **Manual TabController**: More control over lifecycle, animations, and programmatic tab switching

### State Preservation Approaches

- **AutomaticKeepAliveClientMixin**: Keeps widget alive when not visible
- **PageStorageKey**: Preserves scroll position and other state
- **Performance**: Only preserve state when necessary to avoid memory issues

## Quick Start (Basic Example)

The basic example demonstrates:
- DefaultTabController with 3 tabs
- Icons and labels in tabs
- Scrollable tabs
- Material 3 theming

Run: `flutter run -t lib/examples/basic_tabs_example.dart`

## Intermediate: Manual TabController & State Preservation

This example shows:
- Manual TabController with lifecycle management
- State preservation using AutomaticKeepAliveClientMixin
- Listening to tab index changes
- Proper disposal of controllers

Run: `flutter run -t lib/examples/manual_tabs_example.dart`

## Advanced: Collapsing Tabs with NestedScrollView

This example demonstrates:
- NestedScrollView with SliverAppBar
- Pinned TabBar that stays visible while scrolling
- List content in each tab
- Collapsing header behavior

Run: `flutter run -t lib/examples/nested_scroll_tabs_example.dart`

## Styling & Theming (Material 3)

### TabBarTheme Configuration

```dart
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.blue,
    unselectedLabelColor: Colors.grey,
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: Colors.transparent,
  ),
)
```

### Custom Tab Styling

- **Label Colors**: Customize selected/unselected text colors
- **Indicator Style**: Modify the underline indicator appearance
- **Tab Shape**: Use rounded corners or custom shapes
- **Elevation**: Add shadow to the TabBar

## Accessibility & Responsiveness

### Accessibility Features

- **Semantics**: Add semantic labels to tabs
- **Tooltips**: Provide additional context for icon-only tabs
- **Contrast**: Ensure adequate color contrast ratios
- **Dynamic Type**: Test with large font sizes

### Responsive Design

- **Scrollable Tabs**: Use `isScrollable: true` for many tabs
- **Adaptive Layout**: Switch to NavigationRail on larger screens
- **Touch Targets**: Ensure minimum 48x48dp touch targets

## Integration Tips

### Combining with Navigation

- **Named Routes**: Push to detail screens from within tabs
- **Back Button**: Maintain tab state when returning from detail screens
- **Deep Linking**: Handle deep links to specific tabs

### State Management

- **Tab Index**: Preserve selected tab across app lifecycle
- **Content State**: Maintain scroll positions and form data
- **Memory Management**: Dispose controllers properly

## Testing Tips

### Widget Testing

```dart
testWidgets('Tab navigation works correctly', (tester) async {
  await tester.pumpWidget(MyTabApp());
  
  // Test initial tab selection
  expect(find.text('Tab 1 Content'), findsOneWidget);
  
  // Test tab switching
  await tester.tap(find.text('Tab 2'));
  await tester.pumpAndSettle();
  expect(find.text('Tab 2 Content'), findsOneWidget);
  
  // Test state preservation
  await tester.tap(find.text('Tab 1'));
  await tester.pumpAndSettle();
  expect(find.text('Tab 1 Content'), findsOneWidget);
});
```

### Key Test Scenarios

1. **Initial State**: Verify correct tab is selected on startup
2. **Tab Switching**: Ensure content changes when tapping tabs
3. **State Preservation**: Confirm state remains when returning to a tab
4. **Controller Lifecycle**: Test proper disposal and recreation

## Exercises

### Easy Exercise
Add a 4th tab to the basic example and make the tab strip scrollable.

### Intermediate Exercise
Add a badge to a tab showing unread count, updating from a ValueNotifier.

### Advanced Exercise
Build a NestedScrollView with a collapsing header image and pinned tabs.

## Summary

### Key Takeaways

- **DefaultTabController**: Use for simple tab implementations
- **Manual TabController**: Use when you need fine-grained control
- **State Preservation**: Implement with AutomaticKeepAliveClientMixin or PageStorageKey
- **Material 3 Theming**: Apply consistent theming with TabBarTheme
- **Nested Scrolling**: Use NestedScrollView for complex scrolling behaviors
- **Accessibility**: Always consider accessibility and responsive design

### Best Practices

1. **Choose the Right Pattern**: Tabs for peer content, bottom nav for app destinations
2. **Preserve State Wisely**: Only preserve state when necessary to avoid memory issues
3. **Handle Lifecycle**: Properly dispose TabControllers in StatefulWidgets
4. **Test Thoroughly**: Test tab switching, state preservation, and accessibility
5. **Follow Material Design**: Use Material 3 theming and design principles

## Running the Examples

1. **Basic Example**: `flutter run -t lib/examples/basic_tabs_example.dart`
2. **Manual Controller**: `flutter run -t lib/examples/manual_tabs_example.dart`
3. **Nested Scroll**: `flutter run -t lib/examples/nested_scroll_tabs_example.dart`

Each example is self-contained and demonstrates different aspects of tab navigation in Flutter.
