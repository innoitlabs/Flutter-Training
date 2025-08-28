import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// Database provider that manages SQLite database initialization and access
/// Handles database versioning, migrations, and provides a singleton instance
class DatabaseProvider {
  static const String _databaseName = 'localbox.db';
  static const int _databaseVersion = 1; // Start with version 1

  // Singleton pattern for database instance
  static Database? _database;
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  
  factory DatabaseProvider() => _instance;
  DatabaseProvider._internal();

  /// Get the database instance, creating it if necessary
  Future<Database> get database async {
    if (_database != null) return _database!;
    
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize the database with proper path and configuration
  Future<Database> _initDatabase() async {
    try {
      // Get the documents directory for database storage
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, _databaseName);

      // Open the database with version control
      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        // Enable foreign keys for relational data (if needed in future)
        onConfigure: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
      );
    } catch (e) {
      throw Exception('Failed to initialize database: $e');
    }
  }

  /// Create the database schema (called on first install)
  Future<void> _onCreate(Database db, int version) async {
    try {
      // Create tasks table with all necessary columns
      await db.execute('''
        CREATE TABLE tasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          notes TEXT,
          isDone INTEGER NOT NULL DEFAULT 0,
          createdAt INTEGER NOT NULL
        )
      ''');

      // Create index on createdAt for faster sorting
      await db.execute('''
        CREATE INDEX idx_tasks_created_at ON tasks(createdAt)
      ''');

      // Create index on isDone for faster filtering
      await db.execute('''
        CREATE INDEX idx_tasks_is_done ON tasks(isDone)
      ''');

      print('Database created successfully with version $version');
    } catch (e) {
      throw Exception('Failed to create database schema: $e');
    }
  }

  /// Handle database upgrades (called when version increases)
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      print('Upgrading database from version $oldVersion to $newVersion');

      // Handle migrations based on version changes
      if (oldVersion < 2) {
        // Example migration: Add priority column (for future use)
        // await db.execute('ALTER TABLE tasks ADD COLUMN priority INTEGER DEFAULT 0');
        // await db.execute('CREATE INDEX idx_tasks_priority ON tasks(priority)');
      }

      if (oldVersion < 3) {
        // Example migration: Add due date column (for future use)
        // await db.execute('ALTER TABLE tasks ADD COLUMN dueDate INTEGER');
        // await db.execute('CREATE INDEX idx_tasks_due_date ON tasks(dueDate)');
      }

      print('Database upgrade completed successfully');
    } catch (e) {
      throw Exception('Failed to upgrade database: $e');
    }
  }

  /// Close the database connection
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  /// Delete the database file (for testing or reset)
  Future<void> deleteDatabase() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, _databaseName);
      
      await close();
      await databaseFactory.deleteDatabase(path);
      print('Database deleted successfully');
    } catch (e) {
      throw Exception('Failed to delete database: $e');
    }
  }

  /// Get database statistics
  Future<Map<String, dynamic>> getDatabaseStats() async {
    try {
      final db = await database;
      final tasksCount = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM tasks')
      ) ?? 0;
      
      final completedTasksCount = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM tasks WHERE isDone = 1')
      ) ?? 0;
      
      final pendingTasksCount = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM tasks WHERE isDone = 0')
      ) ?? 0;

      return {
        'totalTasks': tasksCount,
        'completedTasks': completedTasksCount,
        'pendingTasks': pendingTasksCount,
        'completionRate': tasksCount > 0 ? (completedTasksCount / tasksCount * 100).round() : 0,
        'databaseVersion': _databaseVersion,
        'databaseName': _databaseName,
      };
    } catch (e) {
      throw Exception('Failed to get database stats: $e');
    }
  }
}
