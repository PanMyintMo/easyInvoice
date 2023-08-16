part of 'product_invoice_cubit.dart';

abstract class ProductInvoiceState extends Equatable {
  const ProductInvoiceState();
}

class ProductInvoiceInitial extends ProductInvoiceState {
  @override
  List<Object> get props => [];
}
class ProductInvoiceLoading extends ProductInvoiceState {
  @override
  List<Object?> get props => [];
}

class ProductInvoiceSuccess extends ProductInvoiceState {

  final List<InvoiceData>  productInvoiceResponse;

  const ProductInvoiceSuccess(this.productInvoiceResponse);
  @override
  List<Object?> get props => [productInvoiceResponse];
}

class ProductInvoiceFail extends ProductInvoiceState {
  final String error;
  const ProductInvoiceFail(this.error);

  @override
  List<Object?> get props => [error];
}

