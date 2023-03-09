import 'package:sqflite/sqflite.dart';

class CategoryModel {
  int? cid;
  String category_name;
  int category_logo_value;
  int isDeleted;

  CategoryModel(
      this.category_name, this.category_logo_value, this.isDeleted);

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
    //id = map['userid'] as int;
    final category_name = map['category_name'] as String;
    final category_logo_value = map['category_logo_id'] as int;
    final isDeleted = map['isDeleted'] as int;

    return CategoryModel(category_name, category_logo_value, isDeleted);
  }
}
