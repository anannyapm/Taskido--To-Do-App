class DBConst {
  final String tableName;
  final String colOne;
  final String colTwo;
  final String colThree;
  final String colFour;

  DBConst(
      {required this.tableName,
      required this.colOne,
      required this.colTwo,
      required this.colThree,
      required this.colFour});
}

DBConst userInstance = DBConst(tableName: 'user_table',colOne: 'id',colTwo: 'name',colThree: 'email',colFour: 'photo');
