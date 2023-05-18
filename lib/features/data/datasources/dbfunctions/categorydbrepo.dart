import 'package:sqflite/sqflite.dart';
import 'package:todoapp/features/data/datasources/dbfunctions/dbhelper.dart';
import 'package:todoapp/features/presentation/constants/databaseconstants.dart';
import 'package:todoapp/features/data/datasources/dbfunctions/repository.dart';
import 'package:todoapp/features/data/models/categorymodel.dart';

class CategRepository {
  static Database? _database;

  //check if database already exist; if yes return it else create a new db and return it.
  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await DatabaseConnection.setDatabase('todo_database.db');
    return _database!;
  }

  //ADD DATA TO DATABASE
  static Future<bool> saveData(CategoryModel category) async {
    var dbClient = await database;

    List<Map<String, dynamic>> result = await fetchData(category.category_name);
    if (result.isEmpty) {
      

      //DBConst===>tableName: 'category_table',colOne: 'cid',colTwo: 'category_name',colThree: 'category_logo',colFour: 'isDeleted'
      category.cid = await dbClient.rawInsert(
          'INSERT INTO ${categoryInstance.tableName}(${categoryInstance.colTwo}, ${categoryInstance.colThree}, ${categoryInstance.colFour}, ${categoryInstance.colFive}) VALUES(?, ?, ?,?)',
          [
            category.category_name,
            category.category_logo_value,
            category.isDeleted,
            Repository.currentUserID
          ]);

      getAllData();

      return true;
    } else {
      return false;
    }
  }

  //FETCH/GET ALL DATA FROM DATABASE
  static Future<List<CategoryModel>> getAllData() async {
    //get data form database
    //rawQuery will return list of map value
    var dbClient = await database;

    int curUserId = Repository.currentUserID;

    final values = await dbClient.rawQuery(
        'select * from ${categoryInstance.tableName} where ${categoryInstance.colFive}="$curUserId"');

    
    final category = values.map((e) => CategoryModel.fromMap(e)).toList();

    return category;
  }

  //FETCH DATA BASED ON EMAIL ID
  static Future<List<Map<String, dynamic>>> fetchData(String categName) async {
    var dbClient = await database;
    int curUserId = Repository.currentUserID;

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'select * from ${categoryInstance.tableName} where ${categoryInstance.colTwo}="$categName" and ${categoryInstance.colFive}="$curUserId"');

    return result;
  }

  //fetch first cid

  static Future<List<Map<String, dynamic>>> fetchFirstCid() async {
    var dbClient = await database;
    int curUserId = Repository.currentUserID;

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'select ${categoryInstance.colOne} from ${categoryInstance.tableName} where ${categoryInstance.colFive}="$curUserId" LIMIT 1');

    return result;
  }

  //DELETE DATA

  static Future<dynamic> deleteData(String categName) async {
    var dbClient = await database;

  
    int curUserId = Repository.currentUserID;

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'delete from ${categoryInstance.tableName} where ${categoryInstance.colTwo}="$categName" and ${categoryInstance.colFive}="$curUserId"');

    getAllData();

    return result;
  }
}
