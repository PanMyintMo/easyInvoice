part of 'get_category_detail_cubit.dart';

abstract class GetCategoryDetailState extends Equatable {
  const GetCategoryDetailState();
}

class GetCategoryDetailInitial extends GetCategoryDetailState {
  @override
  List<Object> get props => [];
}

class GetCategoryDetailLoading extends GetCategoryDetailState{
  @override
  List<Object?> get props => [];
}

class GetCategoryDetailSuccess extends GetCategoryDetailState{
  final List<PaginationItem> getAllCategoryDetail;
  const GetCategoryDetailSuccess(this.getAllCategoryDetail);
  @override

  List<Object?> get props => [getAllCategoryDetail];

}

class GetCategoryDetailFail extends GetCategoryDetailState{
 final String error;
 const GetCategoryDetailFail(this.error);
  @override
  List<Object?> get props =>[error];
}
