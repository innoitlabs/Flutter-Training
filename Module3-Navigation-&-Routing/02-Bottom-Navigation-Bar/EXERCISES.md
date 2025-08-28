# Flutter Bottom Navigation Exercises

## Easy Exercise: Add a 4th Tab

**Objective**: Add a "Settings" tab to the basic navigation example.

**Steps**:
1. Open `lib/main.dart`
2. Add a fourth screen widget called `SettingsScreen`
3. Add it to the `_screens` list
4. Add a fourth `NavigationDestination` to the `NavigationBar`
5. Update the `_selectedIndex` logic to handle 4 tabs

**Expected Result**: A working 4-tab bottom navigation with Home, Search, Profile, and Settings tabs.

## Intermediate Exercise: Add Details Screen

**Objective**: Implement a "Details" screen within the Home tab using the nested navigator pattern.

**Steps**:
1. Open `lib/screens/home/home_screen.dart`
2. Add a button that navigates to a new `HomeDetailsScreen`
3. Create `lib/screens/home/home_details_screen.dart`
4. Implement the details screen with some content
5. Test that the back button works correctly

**Expected Result**: Ability to navigate from Home to Details and back, with proper back button handling.

## Advanced Exercise: Badge Count and State Preservation

**Objective**: Implement dynamic badge counts and state preservation.

**Steps**:
1. **Badge Count**: 
   - Add a global notification counter
   - Update the badge count dynamically
   - Add buttons to increment/decrement the count

2. **State Preservation**:
   - Use `PageStorageKey` to preserve scroll positions
   - Preserve form inputs across tab switches
   - Test state restoration

3. **Global State Management**:
   - Implement a simple state management solution
   - Use `ChangeNotifier` or `ValueNotifier`
   - Share state across different tabs

**Expected Result**: Dynamic badge updates and preserved state across tab switches.

## Bonus Exercise: Responsive Design

**Objective**: Implement responsive navigation that adapts to screen size.

**Steps**:
1. Use `MediaQuery` to detect screen width
2. Switch between `NavigationBar` and `NavigationRail` based on screen size
3. Test on different screen sizes
4. Ensure proper layout on tablets and desktop

**Expected Result**: Navigation that automatically adapts to screen size.

## Testing Exercise: Widget Tests

**Objective**: Write comprehensive widget tests for the bottom navigation.

**Steps**:
1. Test default selected index
2. Test tab switching
3. Test nested navigation
4. Test back button behavior
5. Test badge updates

**Expected Result**: Comprehensive test coverage for all navigation functionality.

## Challenge Exercise: Custom Navigation Bar

**Objective**: Create a custom navigation bar with unique styling.

**Steps**:
1. Create a custom `NavigationBar` widget
2. Add custom animations and transitions
3. Implement custom theming
4. Add unique visual effects

**Expected Result**: A fully customized navigation bar with unique design.

## Solutions

Solutions for these exercises can be found in the `examples/` directory:

- `examples/state_preservation_example.dart` - State preservation implementation
- `examples/responsive_navigation.dart` - Responsive design example
- `examples/legacy_bottom_navigation.dart` - Legacy navigation reference

## Tips for Success

1. **Start Simple**: Begin with the basic example and gradually add complexity
2. **Test Frequently**: Test your changes on both Android and iOS
3. **Use Hot Reload**: Take advantage of Flutter's hot reload for faster development
4. **Check Documentation**: Refer to the Flutter documentation for NavigationBar and NavigationDestination
5. **Follow Material Design**: Ensure your implementation follows Material Design guidelines

## Common Pitfalls to Avoid

1. **Forgetting Back Button Handling**: Always implement proper back button behavior with nested navigators
2. **Ignoring State Management**: Don't forget to preserve important state across tab switches
3. **Poor Accessibility**: Always add proper semantics and labels for accessibility
4. **Not Testing on Different Screen Sizes**: Test your responsive design on various devices
5. **Using Legacy Components**: Prefer Material 3 components over legacy ones

## Next Steps

After completing these exercises, consider exploring:

1. **Advanced State Management**: Provider, Riverpod, or Bloc
2. **Deep Linking**: Implementing deep links with bottom navigation
3. **Custom Transitions**: Creating custom page transitions
4. **Accessibility**: Adding comprehensive accessibility features
5. **Performance Optimization**: Optimizing navigation performance for large apps
