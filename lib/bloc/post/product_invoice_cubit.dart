import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/DeliveryPart/ProductInvoiceResponse.dart';
import 'package:easy_invoice/dataRequestModel/DeliveryPart/ProductInvoiceRequest.dart';
import 'package:equatable/equatable.dart';

import '../../data/userRepository/UserRepository.dart';

part 'product_invoice_state.dart';

class ProductInvoiceCubit extends Cubit<ProductInvoiceState> {
  final UserRepository _userRepository;

  ProductInvoiceCubit(this._userRepository) : super(ProductInvoiceInitial());

  Future<void> productInvoice(ProductInvoiceRequest productInvoiceRequest) async {
    emit(ProductInvoiceLoading());
    try {
      final List<InvoiceData> response = await _userRepository.productInvoice(productInvoiceRequest);
      if (response.isNotEmpty) {
        emit(ProductInvoiceSuccess(response));
      } else {
        emit(const ProductInvoiceFail("No data found."));
      }
    } catch (error) {
      emit(ProductInvoiceFail(error.toString()));
    }
  }
}
