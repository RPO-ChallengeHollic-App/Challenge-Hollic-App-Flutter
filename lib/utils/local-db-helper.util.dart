import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Singleton class for accessing sqlite db on phone
class LocalDatabaseHelper {
  LocalDatabaseHelper._internal();

  static const String _tableName = "user";
  static const String _dbFileName = "local_db.db";

  static final LocalDatabaseHelper _localDbHelper = LocalDatabaseHelper._internal(); // Create a single instance
  late final Database _database;
  bool _isInit = false;

  static LocalDatabaseHelper get get => _localDbHelper;

  Future<Database> _getDatabase() async {
    if (!_isInit) {
      await _initDatabase();
    }
    return _database;
  }

  Future _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, _dbFileName);
    _database = await openDatabase(
      dbPath,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
            CREATE TABLE $_tableName (
              id AUTO INCREMENT PRIMARY KEY,
              refresh_token TEXT NOT NULL
            );
          '''
        );
      }
    );
    _isInit = true;
  }



}