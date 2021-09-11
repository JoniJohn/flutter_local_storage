import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConfig {
  // config database
  Future<Database> initializeDB() async {
    var dbpath = await getDatabasesPath();
    String path = join(dbpath, 'organization.db');
    return await openDatabase(path,
        version: 1, onCreate: _onCreate, onConfigure: _onConfigure);
  }

  // singleton definer
  static final DBConfig _dbConfig = DBConfig._internal();
  DBConfig._internal();
  factory DBConfig() => _dbConfig;

  Future _onCreate(Database db, int version) async => null;
  Future _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }
}
