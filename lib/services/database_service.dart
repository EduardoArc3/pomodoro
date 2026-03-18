import 'package:path/path.dart';
import 'package:pomodoro/models/history_record.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._instance();
  static Database? _db;

  DatabaseService._instance();

  Future<Database> get db async {
    _db ??= await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'pomodoro_pds3.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history_records(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        date TEXT NOT NULL,
        isCompleted INTEGER NOT NULL,
        cycles TEXT NOT NULL,
        totalTime INTEGER NOT NULL,
        isPinned INTEGER NOT NULL
      )
  ''');
  }

  Future<int> insertRecord(HistoryRecord record) async {
    Database db = await instance.db;
    return await db.insert('history_records', record.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllRecords() async {
    Database db = await instance.db;
    return await db.query('history_records');
  }

  // pinnear o despinnear
  Future<int> updatePinStatus(int id, bool isPinned) async {
    Database db = await instance.db;
    return await db.update(
      "history_records",
      {'isPinned': isPinned ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
