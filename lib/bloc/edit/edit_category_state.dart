part of 'edit_category_cubit.dart';

abstract class EditCategoryState extends Equatable {
  const EditCategoryState();
}

class EditCategoryInitial extends EditCategoryState {
  @override
  List<Object> get props => [];
}

class EditCategoryLoading extends EditCategoryState{
  @override
  List<Object?> get props => [];

}

class EditCategorySuccess extends EditCategoryState{

  final UpdateResponse categoryUpdateResponse;
  const EditCategorySuccess(this.categoryUpdateResponse);
  @override
  List<Object?> get props => [categoryUpdateResponse];

}
class EditCategoryFail extends EditCategoryState{
 final String error;
  const EditCategoryFail(this.error);
  @override
  List<Object?> get props => [error];

}
