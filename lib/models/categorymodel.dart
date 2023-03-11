import 'package:sqflite/sqflite.dart';

import 'appviewmodel.dart';

class CategoryModel {
  int? cid;
  final String category_name;
  final int category_logo_value;
  final int isDeleted;

  CategoryModel(
      {required this.category_name,
      required this.category_logo_value,
      required this.isDeleted,
      this.cid});

  /* Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'userid': id,
      'username': name,
      'email': email,
      'photo': photo
    };
    return map;
  } */

  static CategoryModel fromMap(Map<String, dynamic> map) {
    final cid = map['cid'] as int;
    final category_name = map['category_name'] as String;
    final category_logo_value = map['category_logo_id'] as int;
    final isDeleted = map['isDeleted'] as int;

    return CategoryModel(
        category_name: category_name,
        category_logo_value: category_logo_value,
        isDeleted: isDeleted,
        cid: cid);
  }
}
