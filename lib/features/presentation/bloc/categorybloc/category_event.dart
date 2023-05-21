
abstract class CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  String categname;
  int categId;
 
  AddCategoryEvent({required this.categId, required this.categname});
}

class UpdateCategoryEvent extends CategoryEvent {}

class DeleteCategoryEvent extends CategoryEvent {}

class LoadCategoryEvent extends CategoryEvent {}
