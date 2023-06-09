part of 'delete_category_cubit.dart';

 abstract class DeleteCategoryState extends Equatable {
   const DeleteCategoryState();
 }

 class DeleteCategoryInitial extends DeleteCategoryState {
   @override
   List<Object> get props => [];
 }

 class DeleteCategoryLoading extends DeleteCategoryState {
   @override
   List<Object?> get props => [];
 }

 class DeleteCategorySuccess extends DeleteCategoryState {
   final DeleteCategory deleteResponse;

   const DeleteCategorySuccess(this.deleteResponse);

   @override
   List<Object?> get props => [deleteResponse];
 }

 class DeleteCategoryFail extends DeleteCategoryState {
   final String error;

   const DeleteCategoryFail(this.error);

  @override
 List<Object?> get props => [error];
 }
