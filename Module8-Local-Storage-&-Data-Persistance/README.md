# Module 8 — Local Storage & Data Persistence (Dart 3.6.1)

## Learning Objectives
- Implement local data storage in Flutter using multiple approaches
- Use SharedPreferences for simple key-value storage (primitives)
- Work with SQLite (sqflite) for relational data with full CRUD operations
- Implement data caching strategies (in-memory + disk) with invalidation
- Apply best practices for error handling, migrations, and architecture

## Key Concepts Covered

### Storage Strategy Selection
- **SharedPreferences**: Small user settings, flags, and simple data
- **SQLite**: Structured, queryable data (tasks, notes, complex relationships)
- **Files**: Large blobs, JSON dumps, or custom formats (optional)

### Architecture Pattern
- **Layered Design**: UI → Repository → Data Sources (Prefs/DB) → Cache
- **Separation of Concerns**: Models, DAOs, Repositories, Services
- **Database Versioning**: onCreate, onUpgrade, migration strategies

### Caching Strategy
- **In-Memory Cache**: Fast access with TTL (Time To Live)
- **Cache Invalidation**: Manual refresh and automatic invalidation on writes
- **Fallback Chain**: Memory → Disk → Network (when applicable)

## Project Overview: LocalBox

A small app that demonstrates local data persistence with:
- **Settings Tab**: User preferences stored in SharedPreferences
- **Tasks Tab**: Full CRUD operations on tasks stored in SQLite
- **Caching**: In-memory cache with TTL and manual refresh capability
- **Search/Filter**: Basic task filtering and statistics

## Tech Stack & Constraints
- **Dart SDK**: >=3.6.1 <4.0.0
- **Flutter**: Latest stable with Material 3
- **Dependencies**: 
  - shared_preferences: ^2.2.2
  - sqflite: ^2.3.0
  - path: ^1.9.0
  - path_provider: ^2.1.2
- **Null Safety**: Full null safety compliance
- **Architecture**: Repository pattern with clean separation

## File Structure
```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── theme.dart
├── features/
│   ├── settings/
│   │   ├── settings_page.dart
│   │   └── settings_service.dart
│   └── tasks/
│       ├── data/
│       │   ├── task_model.dart
│       │   ├── database_provider.dart
│       │   ├── tasks_dao.dart
│       │   └── tasks_repository.dart
│       └── ui/
│           ├── tasks_page.dart
│           └── task_editor_sheet.dart
└── core/
    ├── cache/
    │   └── memory_cache.dart
    └── utils/
        ├── result.dart
        └── date_formats.dart
```

## Run Instructions

### Prerequisites
- Flutter SDK (latest stable)
- Dart 3.6.1+
- iOS Simulator or Android Emulator

### Setup & Run
1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Start iOS Simulator**
   ```bash
   open -a Simulator
   # Or use Xcode → iOS Simulator
   ```

3. **Verify Device**
   ```bash
   flutter devices
   # Confirm a simulator is listed
   ```

4. **Run the App**
   ```bash
   flutter run -d ios
   ```

### Verification Steps
1. **Settings Persistence**: 
   - Change username and toggle dark mode
   - Close and reopen app
   - Verify values persist (SharedPreferences working)

2. **Tasks CRUD**:
   - Create, edit, toggle, and delete tasks
   - Close and reopen app
   - Verify tasks persist (SQLite working)

3. **Caching**:
   - Load tasks list
   - Quickly navigate away and back
   - List should load instantly (in-memory cache)
   - Pull-to-refresh should bypass cache

4. **Migration**:
   - App handles database versioning automatically
   - No data loss during schema updates

## Best Practices Demonstrated

### Storage Selection
- Use SharedPreferences for small, simple data
- Use SQLite for structured, queryable data
- Plan for data growth and relationships

### Error Handling
- Try/catch blocks around all I/O operations
- Defensive parsing with fallback defaults
- User-friendly error messages

### Caching Strategy
- Cache frequently accessed data
- Implement TTL for cache freshness
- Provide manual refresh capability
- Invalidate cache on writes

### Database Management
- Version your schema
- Write idempotent migrations
- Use transactions for multi-step operations
- Create indices for performance

## Exercises

### Easy
- Add "Clear Completed" action using database transactions
- Implement task completion statistics

### Intermediate
- Add search functionality with SQLite WHERE clauses
- Implement task filtering by status

### Advanced
- Add priority field with migration from v1 to v2
- Create indices on priority column
- Implement sorting by priority and date

## Troubleshooting

### Common Issues
1. **Database not found**: Check path_provider permissions
2. **Migration errors**: Verify onUpgrade logic is idempotent
3. **Cache not working**: Check TTL values and invalidation triggers
4. **SharedPreferences not persisting**: Verify key names and data types

### Debug Tips
- Use `flutter logs` to see database operations
- Add print statements in repository methods
- Test migrations with different app versions
- Verify cache state with debug prints

## Next Steps
- Implement offline-first architecture
- Add data synchronization capabilities
- Explore more advanced caching strategies
- Implement data backup and restore
