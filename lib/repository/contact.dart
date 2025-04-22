import 'package:contatos/repository/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactDatabase {
  static Database? _db;
  static final ContactDatabase _instance = ContactDatabase._internal();

  factory ContactDatabase() => _instance;

  ContactDatabase._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'contact.db');
    final database = await openDatabase(
      version: 1,
      databasePath,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT)',
        );
      },
    );
    return database;
  }

  Future<int> addContact(Map<String, dynamic> contact) async {
    final db = await database;
    try {
      return await db.insert(contactTable, contact);
    } catch (e) {
      throw 'Error: $e';
    }
  }

  Future<List<Contact>> getAllContacs() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> contacs = await db.query(contactTable);
      return contacs.map((contact) => Contact.fromMap(contact)).toList();
    } catch (e) {
      throw 'Error: $e';
    }
  }

  Future<void> removeById(int id) async {
    final db = await database;
    try {
      await db.delete(contactTable, where: '$idColumn = $id');
    } catch (e) {
      throw 'Error: $e';
    }
  }

  Future<void> updateContact(int id, Map<String, dynamic> contact) async {
    final db = await database;
    try {
      await db.update(
        contactTable,
        contact,
        where: '$idColumn = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw 'Error: $e';
    }
  }
}
