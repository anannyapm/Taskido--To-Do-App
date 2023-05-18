class UserModel {
  int? uid;
  final String name;
  final String email;
  final String photo;

  UserModel(
      {required this.name, required this.email, required this.photo, this.uid});

  UserModel fromMap(Map<String, dynamic> map) {
    final uid = map['uid'] as int;
    final name = map['name'] as String;
    final email = map['email'] as String;
    final photo = map['photo'] as String;

    return UserModel(name: name, email: email, photo: photo);
  }
}
