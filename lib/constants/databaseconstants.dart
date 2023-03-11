class DBConst {
  final String tableName;
  final String colOne;
  final String colTwo;
  final String colThree;
  final String colFour;
  final String colFive;

  DBConst(
      {required this.tableName,
      required this.colOne,
      required this.colTwo,
      required this.colThree,
      required this.colFour,
      this.colFive=''}
      );
}

DBConst userInstance = DBConst(
    tableName: 'user_table',
    colOne: 'uid',
    colTwo: 'name',
    colThree: 'email',
    colFour: 'photo');
DBConst categoryInstance = DBConst(
    tableName: 'category_table',
    colOne: 'cid',
    colTwo: 'category_name',
    colThree: 'category_logo_id',
    colFour: 'isDeleted');
DBConst taskInstance = DBConst(
    tableName: 'task_table',
    colOne: 'tid',
    colTwo: 'task_name',
    colThree: 'isCompleted',
    colFour: 'category_id',
    colFive: 'user_id');
