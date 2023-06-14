part of 'edit_size_cubit.dart';

abstract class EditSizeState extends Equatable {
  const EditSizeState();
}

class EditSizeInitial extends EditSizeState {
  @override
  List<Object> get props => [];
}
class EditSizeLoading extends EditSizeState{
  @override
  List<Object?> get props => [];

}
class EditSizeSuccess extends EditSizeState{

  final SizeUpdateResponse sizeUpdateResponse;
  const EditSizeSuccess(this.sizeUpdateResponse);
  @override
  List<Object?> get props => [sizeUpdateResponse];

}
class EditSizeFail extends EditSizeState{
  final String error;
  const EditSizeFail(this.error);
  @override
  List<Object?> get props => [error];

}

