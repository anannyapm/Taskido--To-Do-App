import 'package:sqflite/sqflite.dart';

class UserModel {
  int? id;
  String name;
  String email;
  String photo;

  UserModel(this.name, this.email, this.photo);

  /* Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'userid': id,
      'username': name,
      'email': email,
      'photo': photo
    };
    return map;
  } */

  UserModel fromMap(Map<String, dynamic> map) {
    //id = map['userid'] as int;
    name = map['username'] as String;
    email = map['email'] as String;
    photo = map['photo'] as String;

    return UserModel( name, email, photo)
    ;

  }
}
