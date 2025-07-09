import 'package:book_finder/data/data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

abstract class BookLocalDataSource {
  Future<void> saveBook(BookModel book);
  Future<List<BookModel>> getSavedBooks();
}

class BookLocalDataSourceImpl implements BookLocalDataSource {
  static Database? _database;
  static const String _tableName = 'saved_books';
  static const int _version = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'book_finder.db');
    return await openDatabase(
      path,
      version: _version,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName(
            id TEXT PRIMARY KEY,
            title TEXT,
            author TEXT,
            thumbnailUrl TEXT,
            coverImageUrl TEXT,
            description TEXT,
            firstPublishYear INTEGER
          )
        ''');
      },
    );
  }

  @override
  Future<void> saveBook(BookModel book) async {
    final db = await database;
    await db.insert(
      _tableName,
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if already exists
    );
  }

  @override
  Future<List<BookModel>> getSavedBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return BookModel.fromMap(maps[i]);
    });
  }
}
