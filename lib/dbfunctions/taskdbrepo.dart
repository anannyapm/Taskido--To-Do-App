import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/dbfunctions/dbhelper.dart';
import 'package:todoapp/constants/databaseconstants.dart';
import 'package:todoapp/dbfunctions/repository.dart';

import '../models/taskmodel.dart';

class TaskRepository {
  static Database? _database;

  //check if database already exist; if yes return it else create a new db and return it.
  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await DatabaseConnection.setDatabase('todo_database.db');
    return _database!;
  }

  //ADD DATA TO DATABASE
  static Future<bool> saveData(TaskModel task) async {
    var dbClient = await database;

    List<Map<String, dynamic>> result =
        await fetchData(task.task_name, task.user_id, task.category_id);
    if (result.isEmpty) {
      debugPrint('inserting.....');

      //DBConst===>tableName: 'category_table',colOne: 'cid',colTwo: 'category_name',colThree: 'category_logo',colFour: 'isDeleted'
      task.tid = await dbClient.rawInsert(
          'INSERT INTO ${taskInstance.tableName}(${taskInstance.colTwo}, ${taskInstance.colThree}, ${taskInstance.colFour}, ${taskInstance.colFive}) VALUES(?,?,?,?)',
          [task.task_name, task.isCompleted, task.category_id, task.user_id]);
      getAllData();

      return true;
    } else {
      return false;
    }
  }


  //FETCH/GET ALL DATA FROM DATABASE
  static Future<List<TaskModel>> getAllData() async {
    //get data form database
    //rawQuery will return list of map value
    var dbClient = await database;

    final _values =
        await dbClient.rawQuery('select * from ${taskInstance.tableName}');

    debugPrint(_values.toString());
    return _values.map((e) => TaskModel.fromMap(e)).toList();
  }

  //FETCH DATA BASED ON TASKNAME,UID,CID
  static Future<List<Map<String, dynamic>>> fetchData(
      String taskName, int userid, int catid) async {
    var dbClient = await database;

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'select * from ${taskInstance.tableName} where ${taskInstance.colTwo}="$taskName" AND ${taskInstance.colFour}="$catid" AND ${taskInstance.colFive}="$userid"');

    return result;
  }

  //FETCH DATA BASED ON CID,UID
  static Future<List<Map<String, dynamic>>> fetchDataWithId(
      int catid, int userid) async {
    var dbClient = await database;

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'select * from ${taskInstance.tableName} where ${taskInstance.colFour}="$catid" AND ${taskInstance.colFive}="$userid"');

    return result;
  }

  //FETCH COUNT

  static Future<List<Map<String, dynamic>>> fetchCount(
      int catid, int userid) async {
    var dbClient = await database;

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'select count(*) as count from ${taskInstance.tableName} where ${taskInstance.colFour}="$catid" AND ${taskInstance.colFive}="$userid"');

    return result;
  }

  //FETCH COUNT OF COMPLETED TASK

  static Future<List<Map<String, dynamic>>> fetchCompletedCount(
      int catid, int userid) async {
    var dbClient = await database;

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'select count(*) as count from ${taskInstance.tableName} where ${taskInstance.colFour}="$catid" AND ${taskInstance.colFive}="$userid" AND ${taskInstance.colThree}="true"');

    return result;
  }

  //UPDATE DATA ON COMPLETE

  static Future<List<Map<String, dynamic>>> updateCompletedStatus(
      int taskid, int catid, int userid, bool statusVal) async {
    var dbClient = await database;

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'update ${taskInstance.tableName} set ${taskInstance.colThree}=? where ${taskInstance.colFour}="$catid" AND ${taskInstance.colFive}="$userid" AND ${taskInstance.colOne}="$taskid"',
        [statusVal]);

    return result;
  }

  //DELETE DATA

  static Future<dynamic> deleteData(
      String taskName, int userid, int catid) async {
    var dbClient = await database;

    debugPrint("In delete data function");

    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        'delete from ${taskInstance.tableName} where ${taskInstance.colTwo}="$taskName" AND ${taskInstance.colFour}="$catid" AND ${taskInstance.colFive}="$userid"');

    getAllData();
    return result;
  }
}
