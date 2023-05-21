
import '../datasources/dbfunctions/categorydbrepo.dart';
import '../datasources/dbfunctions/repository.dart';
import '../models/categorymodel.dart';

class CategoryFunctionRepo {
  //category operations

  static List<CategoryModel> categModelList = <CategoryModel>[];

  static Future<bool> addCategory(int choiceIndex, String categName) async {
    final name = categName.trim().replaceAll(RegExp(r"\s+"), " ");
    final logoindex = choiceIndex;

    final categoryObject = CategoryModel(
        category_name: name,
        category_logo_value: logoindex,
        isDeleted: 0,
        user_id: Repository.currentUserID);

    bool out = await CategRepository.saveData(categoryObject);

    return out;
  }

  //create category model list

  static Future<dynamic> addToCategList() async {
    categModelList.clear();
    categModelList = await CategRepository.getAllData();
    
    return categModelList;
   
  }

  static int get categoryCount {
    int count = 0;
    count = categModelList.length;
    return count;
  }
}
