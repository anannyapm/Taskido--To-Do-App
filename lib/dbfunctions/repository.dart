import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/dbfunctions/dbhelper.dart';
import 'package:todoapp/constants/databaseconstants.dart';

import '../models/usermodel.dart';

class Repository {
  static Database? _database;

  //DBConst userInstance = DBConst(tableName: 'user_table',colOne: 'id',colTwo: 'name',colThree: 'email',colFour: 'photo');
  static late int currentUserID;
  static late String currentUserName;
  static late String currentUserMail;
  static late String currentUserPhoto;

  static Future<void> setCurrentUser(id, name, email, photo) async {
    currentUserID = id;
    currentUserName = name;
    currentUserMail = email;
    currentUserPhoto = photo;

    debugPrint(currentUserMail + currentUserName + currentUserPhoto);
  }

  //check if database already exist; if yes return it else create a new db and return it.
  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await DatabaseConnection.setDatabase('todo_database.db');
    return _database!;
  }

  static Future<bool> saveData(UserModel user) async {
    var dbClient = await database;
    /* print("In saveData" + user.email);
    print('all data-'); */

    List<Map<String, dynamic>> result = await fetchData(user.email);
    if (result.isEmpty) {
      //bool res = true;
      //if (result == false) {
      debugPrint('inserting.....');
      user.uid = await dbClient.rawInsert(
          'INSERT INTO ${userInstance.tableName}(${userInstance.colTwo}, ${userInstance.colThree}, ${userInstance.colFour}) VALUES(?, ?, ?)',
          [user.name, user.email, user.photo]);
      getAllUser();

      return true;
    } else {
      return false;
    }

    // return user;
  }

  static Future<void> getAllUser() async {
    //get data form database
    //rawQuery will return list of map value
    var dbClient = await database;

    final _values =
        await dbClient.rawQuery('select * from ${userInstance.tableName}');

    debugPrint(_values.toString());

    //studentListNotifier.value.clear();

    /*  _values.forEach((map) {
    final student = StudentModel.fromMap(map);
    studentListNotifier.value.add(student);
    studentListNotifier.notifyListeners();
  }); */

    //studentListNotifier.notifyListeners();
  }

  static Future<List<Map<String, dynamic>>> fetchData(String email) async {
    var dbClient = await database;

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'select * from ${userInstance.tableName} where ${userInstance.colThree}="$email"');

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

  static Future<List<Map<String, dynamic>>> fetchID(String email) async {
    var dbClient = await database;

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'select ${userInstance.colOne} from ${userInstance.tableName} where ${userInstance.colThree}="$email"');

    return result;
  }
}
