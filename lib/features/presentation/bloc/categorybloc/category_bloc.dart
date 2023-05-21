import 'package:bloc/bloc.dart';
import 'package:todoapp/features/data/models/categorymodel.dart';
import 'package:todoapp/features/data/repositories/categoryfunctions.dart';
import 'package:todoapp/features/presentation/bloc/categorybloc/category_event.dart';
import 'package:todoapp/features/presentation/bloc/categorybloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  List<CategoryModel> categModelList = <CategoryModel>[];

  CategoryBloc() : super(CategInitialState()) {
    on<LoadCategoryEvent>((event, emit) async {
      final categData = await CategoryFunctionRepo.addToCategList();
     
      if (categData == null) {
        emit(CategErrorState(errormsg: "Data Fetch Error"));
      } else {
        int count = CategoryFunctionRepo.categoryCount;
        emit(CategLoadingState(categList: categData, categCount: count));
      }
    });
    on<AddCategoryEvent>((event, emit) async {
      final output = await CategoryFunctionRepo.addCategory(
          event.categId, event.categname);
      if (output != true) {
        emit(CategErrorState(
            errormsg: "Oh Snap! Looks like category already exist!"));
      } else {
        emit(CategCreateState());
        
      }
    });

    /* on<UpdateTaskEvent>(
      (event, emit) {

      },
    ); */
  }
}
