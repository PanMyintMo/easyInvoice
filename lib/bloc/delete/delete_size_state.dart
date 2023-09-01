part of 'delete_size_cubit.dart';

abstract class DeleteSizeState extends Equatable {
  const DeleteSizeState();
}

class DeleteSizeInitial extends DeleteSizeState {
  @override
  List<Object> get props => [];
}

class DeleteSizeLoading extends DeleteSizeState {
  @override
  List<Object?> get props => [];
}

class DeleteSizeSuccess extends DeleteSizeState {
  final DeleteResponse deleteSizeResponse;

  const DeleteSizeSuccess(this.deleteSizeResponse);

  @override
  List<Object?> get props => [deleteSizeResponse];
}

class DeleteSizeFail extends DeleteSizeState {
  final String error;

  const DeleteSizeFail(this.error);

  @override
  List<Object?> get props => [error];
}



