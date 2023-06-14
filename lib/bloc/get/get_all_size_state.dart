part of 'get_all_size_cubit.dart';

abstract class GetAllSizeState extends Equatable {
  const GetAllSizeState();
}

class GetAllSizeInitial extends GetAllSizeState {
  @override
  List<Object> get props => [];
}


class GetAllSizeLoading extends GetAllSizeState{
  @override
  List<Object?> get props => [];
}

class GetAllSizeSuccess extends GetAllSizeState{
  final List<GetAllSizeResponse> getAllSize;
  const GetAllSizeSuccess(this.getAllSize);
  @override

  List<Object?> get props => [getAllSize];

}

class GetAllSizeFail extends GetAllSizeState{
  final String error;
  const GetAllSizeFail(this.error);
  @override
  List<Object?> get props =>[error];
}

