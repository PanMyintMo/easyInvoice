part of 'invoice_cubit.dart';

abstract class InvoiceState extends Equatable {
  const InvoiceState();
}

class InvoiceInitial extends InvoiceState {
  @override
  List<Object> get props => [];
}
class InvoiceLoading extends InvoiceState{
  @override
  List<Object?> get props => [];
}

class InvoiceSuccess extends InvoiceState{
  final Invoice invoice;
  const InvoiceSuccess(this.invoice);
  @override

  List<Object?> get props => [invoice];

}

class InvoiceFail extends InvoiceState{
  final String error;
  const InvoiceFail(this.error);
  @override
  List<Object?> get props =>[error];
}

