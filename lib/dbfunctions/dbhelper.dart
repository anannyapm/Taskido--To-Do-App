import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoapp/constants/databaseconstants.dart';
import 'package:todoapp/models/usermodel.dart';

class DatabaseConnection {
  static setDatabase(String dbname) async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, dbname);

    var database =
        await openDatabase(path, version: 1, onCreate: createDatabase);
    return database;
  }

  static createDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE ${dbConst.tableName} (${dbConst.id} INTEGER PRIMARY KEY AUTOINCREMENT , ${dbConst.name} TEXT, ${dbConst.email} TEXT UNIQUE, ${dbConst.photo} TEXT)");
  }
}
