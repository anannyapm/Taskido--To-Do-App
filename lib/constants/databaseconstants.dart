class DBConst {
  final String tableName;
  final String colOne;
  final String colTwo;
  final String colThree;
  final String colFour;
  final String colFive;
  final String colSix;
  //final String colSeven;



  DBConst(
      {required this.tableName,
      required this.colOne,
      required this.colTwo,
      required this.colThree,
      required this.colFour,
      this.colFive='',
      this.colSix='',
      //this.colSeven=''
      }
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
    colFour: 'isDeleted',
    colFive: 'user_id');
DBConst taskInstance = DBConst(
    tableName: 'task_table',
    colOne: 'tid',
    colTwo: 'task_name',
    colThree: 'isCompleted',
    colFour: 'category_id',
    colFive: 'user_id',
    colSix: 'task_date_time'
    //colSeven: 'task_time'
    );
