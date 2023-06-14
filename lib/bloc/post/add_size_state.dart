part of 'add_size_cubit.dart';

abstract class AddSizeState extends Equatable {
  const AddSizeState();
}

class AddSizeInitial extends AddSizeState {
  @override
  List<Object> get props => [];
}

class AddSizeLoading extends AddSizeState {
  @override
  List<Object?> get props => [];
}

class AddSizeSuccess extends AddSizeState {
  final AddSizeResponse addSizeResponse;

  const AddSizeSuccess(this.addSizeResponse);

  @override
  List<Object?> get props => [addSizeResponse];
}

class AddSizeFail extends AddSizeState {
  final String error;

  const AddSizeFail(this.error);

  @override
  List<Object?> get props => [error];

}

