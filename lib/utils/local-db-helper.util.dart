import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Singleton class for accessing sqlite db on phone
class LocalDatabaseHelper {
  LocalDatabaseHelper._internal();

  static const String _tableName = "user";
  static const String _dbFileName = "tokens_db.db";

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
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
            CREATE TABLE $_tableName (
              id AUTO INCREMENT PRIMARY KEY,
              refresh_token TEXT NOT NULL,
              access_token TEXT NOT  NULL
            );
          '''
        );
      }
    );
    _isInit = true;
  }
  
  Future<void> storeTokens(String access, String refresh) async {

    Database database =  await _getDatabase();
    final oldToken = await getToken();
    if (oldToken == null) {
      await database.rawInsert("INSERT INTO $_tableName (access_token, refresh_token) VALUES(?);", [access, refresh]);
    } else {
      await database.rawUpdate("UPDATE $_tableName SET refresh_token = ?, access_token = ?", [refresh, access]);
    }
  }
  
  Future<Map<String, dynamic>?> getToken() async {
    Database database =  await _getDatabase();
    final result = await database.rawQuery("SELECT * FROM $_tableName");
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

}