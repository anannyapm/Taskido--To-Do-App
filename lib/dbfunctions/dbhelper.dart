import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoapp/constants/databaseconstants.dart';
import 'package:todoapp/constants/iconlist.dart';
import 'package:todoapp/models/usermodel.dart';

class DatabaseConnection {

  

  static setDatabase(
    String dbname,
  ) async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, dbname);

    var database =
        await openDatabase(path, version: 1, onCreate: createDatabase,onConfigure: _onConfigure);
    return database;
  }

  static _onConfigure(Database database) async {
  // Add support for cascade delete
  await database.execute("PRAGMA foreign_keys = ON");
}

  static createDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE ${userInstance.tableName} (${userInstance.colOne} INTEGER PRIMARY KEY AUTOINCREMENT , ${userInstance.colTwo} TEXT NOT NULL, ${userInstance.colThree} TEXT UNIQUE NOT NULL, ${userInstance.colFour} TEXT NOT NULL)");

    await database.execute(
        "CREATE TABLE ${categoryInstance.tableName} (${categoryInstance.colOne} INTEGER PRIMARY KEY AUTOINCREMENT , ${categoryInstance.colTwo} TEXT NOT NULL, ${categoryInstance.colThree} INT NOT NULL, ${categoryInstance.colFour} BOOLEAN NOT NULL,${categoryInstance.colFive} INT NOT NULL,FOREIGN KEY (${categoryInstance.colFive}) REFERENCES ${userInstance.tableName}(${userInstance.colOne}) ON DELETE CASCADE,UNIQUE(${categoryInstance.colTwo},${categoryInstance.colFive}))");

     /* await database.rawInsert(
        'INSERT INTO ${categoryInstance.tableName}(${categoryInstance.colTwo}, ${categoryInstance.colThree}, ${categoryInstance.colFour}) VALUES(?, ?, ?)',
        ['Personal', 0, false]);
    await database.rawInsert(
        'INSERT INTO ${categoryInstance.tableName}(${categoryInstance.colTwo}, ${categoryInstance.colThree}, ${categoryInstance.colFour}) VALUES(?, ?, ?)',
        ['Work',1 , false]);  */
   

    
    await database.execute(
        "CREATE TABLE ${taskInstance.tableName} (${taskInstance.colOne} INTEGER PRIMARY KEY AUTOINCREMENT , ${taskInstance.colTwo} TEXT NOT NULL , ${taskInstance.colThree} INTEGER NOT NULL, ${taskInstance.colFour} INT NOT NULL,${taskInstance.colFive} INT NOT NULL,FOREIGN KEY (${taskInstance.colFour}) REFERENCES ${categoryInstance.tableName}(${categoryInstance.colOne}) ON DELETE CASCADE,FOREIGN KEY (${taskInstance.colFive}) REFERENCES ${userInstance.tableName}(${userInstance.colOne}) ON DELETE CASCADE)");
         
  }
}
