import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/dbfunctions/dbhelper.dart';
import 'package:todoapp/constants/databaseconstants.dart';
import 'package:todoapp/models/appviewmodel.dart';
import 'package:todoapp/models/categorymodel.dart';

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
      debugPrint('inserting.....');

      //DBConst===>tableName: 'category_table',colOne: 'cid',colTwo: 'category_name',colThree: 'category_logo',colFour: 'isDeleted'
      category.cid =await dbClient.rawInsert(
          'INSERT INTO ${categoryInstance.tableName}(${categoryInstance.colTwo}, ${categoryInstance.colThree}, ${categoryInstance.colFour}) VALUES(?, ?, ?)',
          [
            category.category_name,
            category.category_logo_value,
            category.isDeleted
          ]);
      getAllData();

      return true;
    } else {
      return false;
    }
  }

  //FETCH?GET ALL DATA FROM DATABASE
  static Future<List<CategoryModel>> getAllData() async {
    //get data form database
    //rawQuery will return list of map value
    var dbClient = await database;

    final _values =
        await dbClient.rawQuery('select * from ${categoryInstance.tableName}');

    debugPrint(_values.toString());
    return _values.map((e) => CategoryModel.fromMap(e)).toList();
  }

  //FETCH DATA BASED ON EMAIL ID
  static Future<List<Map<String, dynamic>>> fetchData(String categName) async {
    var dbClient = await database;

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'select * from ${categoryInstance.tableName} where ${categoryInstance.colTwo}="$categName"');

    return result;
  }

  //DELETE DATA

  static Future<dynamic> deleteData(String categName) async {
    var dbClient = await database;

    debugPrint("In delete repo");

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'delete from ${categoryInstance.tableName} where ${categoryInstance.colTwo}="$categName"');

    return result;
  }
}
