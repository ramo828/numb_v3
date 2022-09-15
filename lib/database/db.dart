import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'model/user.dart';
import 'package:path/path.dart' as path;

class myDataBase {
  final int _version = 1; // verisya
  String tableName = "userDB"; // Tablo adi

//Baza yaratmaq ucun
  Future<Database> open() async {
    final dbPath = await sql.getDatabasesPath();
    final db1 = await openDatabase(
      path.join(dbPath, 'users.db'),
      version: _version,
      onCreate: (db, version) {
        createDB(db);
      },
    );
    return db1;
  }
//Tablomuz
// Modele uygun hazirlanmalidi

  Future<void> createDB(Database db) async {
    await db.execute("""
    CREATE TABLE if NOT EXISTS $tableName (id int, user TEXT, password TEXT)
""");
  }
// Butun melumatlari tek datadan almaq ucun

  Future<List<userDB>?> getList() async {
    Database db = await open();
    List<Map<String, Object?>>? userList = await db.query(tableName);
    return userList.map((e) => userDB.fromJson(e)).toList();
  }

// id gore data almaq ucun
  Future<List<Map<String, Object?>>> getItem(int id) async {
    Database db = await open();

    final map = await db.query(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
    return map;
  }

// ID gore silmek ucun

  Future<bool> deleteUser(int id) async {
    Database db = await open();

    final map = await db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
    return map != null;
  }

// Melumati deyismek ucun
  Future<bool> update(int id, userDB user) async {
    Database db = await open();

    final map = await db.update(
      tableName,
      user.toJson(),
      where: "id = ?",
      whereArgs: [id],
    );
    return map != null;
  }
// yeni melumat elave etmek ucun

  Future<bool> insert(userDB user) async {
    Database db = await open();

    final map = await db.insert(
      tableName,
      user.toJson(),
    );
    return map != null;
  }

// Verilenler bazasini baglamaq ucun
  void close() async {
    Database db = await open();
    db.close();
  }

  Future<bool> clearDB() async {
    Database db = await open();
    final map = db.rawQuery('DELETE FROM $tableName');
    return map != null;
  }

  Future<String> databasePath() async {
    return await databasePath();
  }

  Future<bool> databaseExists(String path) =>
      databaseFactory.databaseExists(path);

  Future<String> getUser(String key) async {
    Database db = await open();
    List<Map<String, Object?>> user = await getItem(0);
    String data = user[0][key].toString();
    if (data != null)
      return data;
    else
      return "Bos";
  }
}
