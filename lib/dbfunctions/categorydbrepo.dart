import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/dbfunctions/dbhelper.dart';
import 'package:todoapp/constants/databaseconstants.dart';
import 'package:todoapp/models/appviewmodel.dart';
import 'package:todoapp/models/categorymodel.dart';

class CategRepository {
  static Database? _database;

  static AppViewModel _viewModel = AppViewModel();

  //check if database already exist; if yes return it else create a new db and return it.
  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await DatabaseConnection.setDatabase('todo_database.db');
    return _database!;
  }

  static Future<bool> saveData(CategoryModel category) async {
    var dbClient = await database;
    /* print("In saveData" + user.email);
    print('all data-'); */

    List<Map<String, dynamic>> result = await fetchData(category.category_name);
    if (result.isEmpty) {
      //bool res = true;
      //if (result == false) {
      debugPrint('inserting.....');
      //user.id =
      await dbClient.rawInsert(
//DBConst(tableName: 'category_table',colOne: 'cid',colTwo: 'category_name',colThree: 'category_logo',colFour: 'isDeleted');

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

    // return user;
  }

  static Future<void> getAllData() async {
    //get data form database
    //rawQuery will return list of map value
    var dbClient = await database;

    final _values =
        await dbClient.rawQuery('select * from ${categoryInstance.tableName}');

    debugPrint(_values.toString());
    if(_values.isNotEmpty)
      _viewModel.addCategoryList(_values);
    //studentListNotifier.value.clear();

    //studentListNotifier.notifyListeners();
  }

  static Future<List<Map<String, dynamic>>> fetchData(String categName) async {
    //print("in fecth" + email);
    var dbClient = await database;

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'select * from ${categoryInstance.tableName} where ${categoryInstance.colTwo}="$categName"');

    return result;
    /* if (result.isNotEmpty) {

      debugPrint('In FetchData');
      debugPrint(result.toString());
      
      return true;

      /* for (var res in res) {
        if (res["email"] == email && res["password"] == password) {
          currentUser = User.fromMap(res);
        }
      } */
    } else {
      debugPrint('no data');
      return false;
    }*/
  }
}
