import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/userRepository/UserRepository.dart';
import '../../../widget/ProviceInvoicePart/InvoiceResponse/Invoice.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final UserRepository _userRepository;

  InvoiceCubit(this._userRepository)
      : super(InvoiceInitial());

  Future<void> generateInvoice() async {
    emit(InvoiceLoading());

    try {
      final response = await _userRepository.generateInvoice();
      emit(InvoiceSuccess(response));
    } catch (error) {
      emit(InvoiceFail(error.toString()));
    }
  }
}