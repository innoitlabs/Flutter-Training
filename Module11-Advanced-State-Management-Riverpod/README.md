# Module 11 — Advanced State Management with Riverpod (Dart 3.6.1)

## Learning Objectives

- **Implement Riverpod** for app/feature state management
- **Create and use providers** and consumers (ConsumerWidget, ref)
- **Handle async state** with FutureProvider, StreamProvider, AsyncNotifier, and AsyncValue
- **Implement dependency injection** via provider overrides (per scope & in tests)

## Key Concepts Covered

### Riverpod Fundamentals
- **ProviderScope**: Root container that enables Riverpod throughout the app
- **WidgetRef**: Access to providers in ConsumerWidgets
- **ref.watch/read/listen**: Different ways to interact with providers
  - `ref.watch()`: Creates dependency and rebuilds when provider changes
  - `ref.read()`: One-time read without creating dependency
  - `ref.listen()`: Reacts to changes without rebuilding

### Provider Types
- **Provider**: Read-only computed values
- **StateProvider**: Simple mutable state
- **FutureProvider**: One-time async operations
- **StreamProvider**: Continuous data streams
- **StateNotifierProvider**: Complex state with business logic
- **AsyncNotifierProvider**: Modern async state management

### Consumers
- **ConsumerWidget**: Widget that can access providers
- **Consumer**: Scoped provider access
- **ref.listen**: Side effects on state changes

### Auto-dispose & Lifecycle
- **Auto-dispose providers**: Automatically cleaned up when not used
- **Resource management**: Proper cancellation of streams/timers
- **ref.keepAlive**: Prevent auto-disposal

### Dependency Injection & Overrides
- **Provider overrides**: Replace implementations for testing/features
- **Scoped overrides**: Different implementations per feature
- **Fake/mock repositories**: Test with predictable data

## Project: RiverpodHub

A comprehensive demo app with three main features demonstrating different Riverpod patterns:

### 1. Counter Tab
- **StateProvider** vs **StateNotifierProvider** comparison
- **Select optimization** to minimize rebuilds
- **ref.listen** for side effects (snackbars on thresholds)
- **Derived providers** for computed values

### 2. Todos Tab
- **CRUD operations** with StateNotifier
- **Dependency injection** via Provider for repository
- **Derived providers** for filtering and statistics
- **Provider overrides** demonstration

### 3. Async Feed Tab
- **FutureProvider** for one-time data fetching
- **StreamProvider** for real-time ticker
- **AsyncNotifier** for complex async state management
- **Auto-dispose providers** for resource management

## Architecture & Best Practices

### Provider Selection Guidelines
- **Provider**: Computed values, derived state
- **StateProvider**: Simple mutable state (counters, toggles)
- **FutureProvider**: API calls, one-time async operations
- **StreamProvider**: Real-time data, WebSocket connections
- **StateNotifierProvider**: Complex business logic, multiple actions
- **AsyncNotifierProvider**: Modern async state with loading/error handling

### AsyncValue Best Practices
```dart
// Use .when() for comprehensive state handling
asyncValue.when(
  data: (data) => DataWidget(data: data),
  loading: () => LoadingWidget(),
  error: (error, stack) => ErrorWidget(error: error),
);

// Use .maybeWhen() for partial state handling
asyncValue.maybeWhen(
  data: (data) => DataWidget(data: data),
  orElse: () => LoadingOrErrorWidget(),
);
```

### Optimization Techniques
- **Select**: Only rebuild when specific value changes
- **Derived providers**: Compute values from other providers
- **Small Consumer scopes**: Minimize rebuild area
- **Auto-dispose**: Clean up unused resources

### Testing Strategy
- **Unit test notifiers** with ProviderContainer
- **Widget test** with provider overrides
- **Fake repositories** for predictable test data
- **Provider overrides** for dependency injection

## Code Structure

```
lib/
├── main.dart                 # App entry point with ProviderScope
├── app/
│   ├── app.dart             # Main app scaffold with navigation
│   └── theme.dart           # Material 3 theming
├── features/
│   ├── counter/             # Basic provider patterns
│   │   ├── counter_page.dart
│   │   ├── counter_providers.dart
│   │   └── counter_notifier.dart
│   ├── todos/               # StateNotifier + DI
│   │   ├── todos_page.dart
│   │   ├── todo_providers.dart
│   │   ├── todos_notifier.dart
│   │   ├── todo_model.dart
│   │   └── todo_repository.dart
│   └── feed/                # Async patterns
│       ├── feed_page.dart
│       ├── feed_providers.dart
│       └── feed_controller.dart
└── shared/
    └── widgets/
        └── async_value_view.dart  # Reusable AsyncValue widget
test/
├── unit/                    # Unit tests
│   ├── counter_notifier_test.dart
│   └── todo_notifier_test.dart
└── widget/                  # Widget tests
    └── overrides_test.dart
```

## Run & Verify — iOS Simulator

### Prerequisites
- Flutter SDK (latest stable)
- Dart 3.6.1
- iOS Simulator or physical iOS device
- Xcode (for iOS development)

### Setup Steps

1. **Install dependencies**
   ```bash
   flutter pub get
   ```

2. **Launch iOS Simulator**
   ```bash
   open -a Simulator
   ```
   Or launch via Xcode: Xcode → Open Developer Tool → Simulator

3. **Check available devices**
   ```bash
   flutter devices
   ```
   Confirm an iOS simulator is listed

4. **Run the app**
   ```bash
   flutter run -d ios
   ```

### Verification Checklist

#### Counter Tab
- [ ] Buttons update counter values
- [ ] Parity badge (EVEN/ODD) uses select optimization
- [ ] Status text shows Zero/Positive/Negative
- [ ] Snackbars appear at thresholds (10, -5)
- [ ] Both StateProvider and StateNotifierProvider work

#### Todos Tab
- [ ] Add new todos via FAB
- [ ] Toggle todo completion status
- [ ] Delete todos with trash icon
- [ ] Filter todos (All/Active/Completed)
- [ ] Statistics update correctly
- [ ] "Mark All Complete" and "Clear Completed" work
- [ ] Settings menu switches between fake/real repositories

#### Feed Tab
- [ ] **FutureProvider tab**: Shows loading → data list
- [ ] **StreamProvider tab**: Ticker updates every second
- [ ] **AsyncNotifier tab**: Add/remove/refresh items work
- [ ] **AutoDispose tab**: Fresh data on each visit
- [ ] Error handling with retry buttons
- [ ] Combined data shows both feed and ticker

#### Navigation & Lifecycle
- [ ] Navigate between tabs smoothly
- [ ] Auto-dispose providers reset when leaving tab
- [ ] State persists when switching tabs
- [ ] No memory leaks or performance issues

## Testing

### Run Unit Tests
```bash
flutter test test/unit/
```

### Run Widget Tests
```bash
flutter test test/widget/
```

### Run All Tests
```bash
flutter test
```

## Exercises

### Easy: Add Todo Filter
Add a filter provider for Todos using StateProvider<Filter>:
```dart
enum Filter { all, active, completed }
final filterProvider = StateProvider<Filter>((ref) => Filter.all);
```

### Intermediate: Convert Feed to AsyncNotifier
Convert the Feed FutureProvider to an AsyncNotifier with:
- Pull-to-refresh functionality
- Error retry mechanism
- Optimistic updates

### Advanced: Add Pagination
Implement pagination in the Feed using:
- StateNotifier with loading states
- Derived providers for total count
- Select optimization for performance

## Best Practices Recap

### Provider Design
- **Keep providers small and focused**
- **Choose appropriate provider type** for your use case
- **Use derived providers** for computed values
- **Optimize with select** to minimize rebuilds

### Async State Management
- **Use AsyncValue.when()** for comprehensive state handling
- **Handle loading, error, and success states** properly
- **Implement retry mechanisms** for better UX
- **Use AsyncNotifier** for complex async logic

### Testing
- **Unit test notifiers** thoroughly
- **Use provider overrides** for dependency injection
- **Test with fake repositories** for predictable results
- **Widget test with overrides** for UI testing

### Performance
- **Use auto-dispose** for expensive operations
- **Implement proper cleanup** with ref.onDispose
- **Optimize rebuilds** with select and Consumer scopes
- **Monitor memory usage** and dispose resources

## Troubleshooting

### Common Issues
1. **Provider not found**: Ensure ProviderScope wraps your app
2. **State not updating**: Check if using ref.watch() instead of ref.read()
3. **Memory leaks**: Use auto-dispose for long-lived providers
4. **Test failures**: Verify provider overrides are correct

### Debug Tips
- Use `ref.listen()` to debug state changes
- Add print statements in provider creation
- Check provider dependencies with `ref.debugPrintDependencies()`
- Monitor rebuilds with Flutter Inspector

## Resources

- [Riverpod Documentation](https://riverpod.dev/)
- [Riverpod GitHub](https://github.com/rrousselGit/riverpod)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)

---

**Happy coding with Riverpod! 🚀**
