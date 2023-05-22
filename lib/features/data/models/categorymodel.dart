// ignore_for_file: non_constant_identifier_names

class CategoryModel {
  int? cid;
  final String category_name;
  final int category_logo_value;
  final int isDeleted;
  final int user_id;

  CategoryModel(
      {required this.category_name,
      required this.category_logo_value,
      required this.isDeleted,
      required this.user_id,
      this.cid});

  static CategoryModel fromMap(Map<String, dynamic> map) {
    final cid = map['cid'] as int;
    final category_name = map['category_name'] as String;
    final category_logo_value = map['category_logo_id'] as int;
    final isDeleted = map['isDeleted'] as int;
    final user_id = map['user_id'] as int;

    return CategoryModel(
        category_name: category_name,
        category_logo_value: category_logo_value,
        isDeleted: isDeleted,
        user_id: user_id,
        cid: cid);
  }
}
