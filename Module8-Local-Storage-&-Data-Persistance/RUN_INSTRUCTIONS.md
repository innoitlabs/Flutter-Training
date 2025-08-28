# LocalBox - Run Instructions

## Prerequisites

- Flutter SDK (latest stable)
- Dart 3.6.1+
- iOS Simulator or Android Emulator
- Xcode (for iOS development)

## Quick Start

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Verify Setup
```bash
flutter doctor
flutter analyze
flutter test
```

### 3. Start iOS Simulator
```bash
# Option 1: Using command line
open -a Simulator

# Option 2: Using Xcode
# Open Xcode → Window → Devices and Simulators → iOS Simulator
```

### 4. List Available Devices
```bash
flutter devices
```

### 5. Run the App
```bash
# Run on iOS Simulator
flutter run -d ios

# Or run on specific device (replace with your device ID)
flutter run -d "5055235D-FA52-4AFF-BB11-984C960121DE"
```

## Verification Steps

### 1. Settings Persistence Test
1. Navigate to the Settings tab
2. Change the username to "Test User"
3. Toggle Dark Mode on/off
4. Close the app completely
5. Reopen the app
6. Verify that your settings are preserved

### 2. Tasks CRUD Test
1. Navigate to the Tasks tab
2. Tap the + button to add a new task
3. Enter a title and optional notes
4. Save the task
5. Toggle the task completion status
6. Edit the task by tapping the edit icon
7. Delete the task by swiping left
8. Close and reopen the app
9. Verify that tasks persist

### 3. Caching Test
1. Load the tasks list (this populates the cache)
2. Quickly navigate to Settings and back to Tasks
3. The list should load instantly (from cache)
4. Pull down to refresh - this bypasses the cache
5. The list should reload from the database

### 4. Search Functionality
1. Create several tasks with different titles
2. Use the search bar to filter tasks
3. Verify that both title and notes are searchable
4. Clear the search to see all tasks again

### 5. Database Migration Test
1. The app starts with database version 1
2. Future migrations can be tested by updating the version in `DatabaseProvider`
3. The app handles migrations automatically

## Troubleshooting

### Common Issues

1. **"No devices found"**
   - Run `flutter devices` to see available devices
   - Start iOS Simulator: `open -a Simulator`
   - For Android: Start Android Studio and launch an emulator

2. **"Failed to initialize database"**
   - Check that `path_provider` permissions are correct
   - Verify the app has write permissions

3. **"Cache not working"**
   - Check TTL values in `MemoryCache`
   - Verify cache invalidation triggers

4. **"SharedPreferences not persisting"**
   - Check key names and data types
   - Verify the settings service is working correctly

### Debug Commands

```bash
# Check Flutter setup
flutter doctor

# Analyze code for issues
flutter analyze

# Run tests
flutter test

# Clean and rebuild
flutter clean
flutter pub get

# Check device connectivity
flutter devices

# View logs
flutter logs
```

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── app/
│   ├── app.dart                       # Main app widget
│   └── theme.dart                     # Material 3 theme
├── features/
│   ├── settings/
│   │   ├── settings_page.dart         # Settings UI
│   │   └── settings_service.dart      # SharedPreferences service
│   └── tasks/
│       ├── data/
│       │   ├── task_model.dart        # Task data model
│       │   ├── database_provider.dart # SQLite database setup
│       │   ├── tasks_dao.dart         # Database operations
│       │   └── tasks_repository.dart  # Repository with caching
│       └── ui/
│           ├── tasks_page.dart        # Tasks list UI
│           └── task_editor_sheet.dart # Task editor
└── core/
    ├── cache/
    │   └── memory_cache.dart          # In-memory cache
    └── utils/
        ├── result.dart                # Result type for error handling
        └── date_formats.dart          # Date formatting utilities
```

## Key Features Demonstrated

### 1. SharedPreferences (Settings)
- Username storage
- Dark mode preference
- Launch count tracking
- Notifications settings
- Auto-save settings

### 2. SQLite Database (Tasks)
- Full CRUD operations
- Search functionality
- Task completion tracking
- Database versioning
- Migration support

### 3. Caching Strategy
- In-memory cache with TTL
- Cache invalidation on writes
- Manual refresh capability
- Fallback to database

### 4. Error Handling
- Result type for type-safe error handling
- User-friendly error messages
- Defensive parsing
- Graceful degradation

### 5. UI/UX Features
- Material 3 design
- Pull-to-refresh
- Swipe-to-delete with undo
- Search and filtering
- Responsive design

## Performance Notes

- Tasks are cached for 30 seconds
- Settings are cached for 5 minutes
- Database queries are optimized with indices
- UI updates are batched for smooth performance

## Next Steps

1. **Add more features:**
   - Task categories/tags
   - Due dates and reminders
   - Task priorities
   - Data export/import

2. **Enhance caching:**
   - Disk caching for offline support
   - Cache compression
   - Background cache cleanup

3. **Improve testing:**
   - Integration tests
   - Widget tests
   - Performance tests

4. **Add analytics:**
   - Usage tracking
   - Performance monitoring
   - Error reporting

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review the code comments for implementation details
3. Run `flutter doctor` to verify your setup
4. Check the Flutter documentation for general guidance
