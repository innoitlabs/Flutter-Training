# RiverpodHub Setup Instructions

## Quick Start

### Prerequisites
- Flutter SDK (latest stable)
- Dart 3.6.1
- iOS Simulator or Android Emulator
- Xcode (for iOS development)

### Setup Steps

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Launch iOS Simulator**
   ```bash
   open -a Simulator
   ```
   Or launch via Xcode: Xcode → Open Developer Tool → Simulator

3. **Check Available Devices**
   ```bash
   flutter devices
   ```

4. **Run the App**
   ```bash
   flutter run -d ios
   ```
   Or for Android:
   ```bash
   flutter run -d android
   ```

## What You'll See

### Counter Tab
- **StateProvider Example**: Simple counter with +/- buttons
- **StateNotifierProvider Example**: Advanced counter with methods
- **Optimization**: EVEN/ODD badge uses `select` to minimize rebuilds
- **Side Effects**: Snackbars appear at thresholds (10, -5)

### Todos Tab
- **CRUD Operations**: Add, toggle, delete todos
- **Filtering**: All/Active/Completed filters
- **Statistics**: Real-time counts
- **Dependency Injection**: Settings menu shows DI concept

### Feed Tab
- **FutureProvider**: One-time data fetching with loading states
- **StreamProvider**: Real-time ticker updates
- **AsyncNotifier**: Complex async state management
- **AutoDispose**: Resource management demonstration

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

## Key Features Demonstrated

### Riverpod Patterns
- ✅ ProviderScope setup
- ✅ ConsumerWidget usage
- ✅ ref.watch/read/listen
- ✅ StateProvider vs StateNotifierProvider
- ✅ FutureProvider and StreamProvider
- ✅ AsyncNotifier for complex async state
- ✅ Auto-dispose providers
- ✅ Derived providers
- ✅ Provider overrides for testing

### Best Practices
- ✅ AsyncValue.when() for state handling
- ✅ Select optimization
- ✅ Dependency injection
- ✅ Error handling with retry
- ✅ Resource cleanup
- ✅ Unit and widget testing

### Material 3 Design
- ✅ Modern UI with Material 3
- ✅ Color scheme from seed
- ✅ Responsive design
- ✅ Accessibility support

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

## Next Steps

### Exercises
1. **Easy**: Add a filter provider for Todos
2. **Intermediate**: Convert Feed to AsyncNotifier with pull-to-refresh
3. **Advanced**: Add pagination to Feed

### Resources
- [Riverpod Documentation](https://riverpod.dev/)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Material 3 Design](https://m3.material.io/)

---

**Happy coding with Riverpod! 🚀**

