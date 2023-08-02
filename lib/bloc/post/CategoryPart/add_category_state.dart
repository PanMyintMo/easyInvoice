part of 'add_category_cubit.dart';

abstract class AddCategoryState extends Equatable {
  const AddCategoryState();
}

class AddCategoryInitial extends AddCategoryState {
  @override
  List<Object> get props => [];
}

class AddCategoryLoading extends AddCategoryState {
  @override
  List<Object?> get props => [];
}

class AddCategorySuccess extends AddCategoryState {
  final AddCategoryResponse addCategoryResponse;

  const AddCategorySuccess(this.addCategoryResponse);

  @override
  List<Object?> get props => [addCategoryResponse];
}

class AddCategoryFail extends AddCategoryState {
  final String error;

  const AddCategoryFail(this.error);

  @override
  List<Object?> get props => [error];

}
