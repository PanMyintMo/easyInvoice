import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/widget/ProviceInvoicePart/PdfPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../common/FormValidator.dart';
import '../../data/responsemodel/DeliveryPart/ProductInvoiceResponse.dart';
import '../../dataRequestModel/DeliveryPart/ProductInvoiceRequest.dart';
import '../../bloc/post/product_invoice_cubit.dart';
import '../../dataRequestModel/DeliveryPart/UpdateQuantityInBarcodeRequest.dart'; // Make sure to import the product_invoice_cubit

class ProductInvoiceWidget extends StatefulWidget {
  final bool isLoading;
  final List<InvoiceData> invoiceData;

  const ProductInvoiceWidget({
    Key? key,
    required this.isLoading,
    required this.invoiceData,
  }) : super(key: key);

  @override
  State<ProductInvoiceWidget> createState() => _ProductInvoiceWidgetState();
}

class _ProductInvoiceWidgetState extends State<ProductInvoiceWidget> {
  var prouductno = TextEditingController();
  bool isClick = false;
  var quantity = TextEditingController();
  int qty = 0;

  @override
  void initState() {
    super.initState();
    // prouductno.addListener(_checkInput);
  }

  // void _checkInput() {
  //   setState(() {
  //     isClick = prouductno.text.isNotEmpty;
  //   });
  // }


  void _updateQuantityAndTotal(InvoiceData item, int newQuantity) async {
    await ApiService().updatedQuantityItemBarcode(
      UpdateQuantityBarcodeRequest(
        quantity: newQuantity.toString(),
        invoice_id: item.id.toString(),
      ),
    );

    setState(() {
      item.quantity = newQuantity;
      item.total = newQuantity * int.parse(item.sale_price);
    });
  }


  Future<void> barcodeScanner() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(
          cancelButtonText: "Cancel",
          scanType: ScanType.barcode,
        ),
      ),
    );

    if (result != null) {
      // Assuming the result contains the scanned barcode string
      String scannedBarcode = result.toString(); // Modify this line

      setState(() {
        prouductno.text = scannedBarcode;
      });
    }
  }

  void _handleSearch() {
    if (prouductno.text.isNotEmpty) {
      isClick = true;
      context
          .read<ProductInvoiceCubit>()
          .productInvoice(ProductInvoiceRequest(barcode: prouductno.text));

      // Clear the text field after using the entered value
      prouductno.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: barcodeScanner,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                      ),
                      child: const Icon(
                        Icons.qr_code_scanner,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: true
                      ? () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => PdfPage()));
                        }
                      : null,
                  child: const Text('Print'),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: prouductno,
                validator: validateField,
                onEditingComplete: _handleSearch,
                decoration: InputDecoration(
                  labelText: 'Invoice Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text('Product Name',
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54)),
                    ),
                    DataColumn(
                      label: Text('QTY',
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54)),
                    ),
                    DataColumn(
                      label: Text('Sale Price',
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54)),
                    ),
                    DataColumn(
                      label: Text('Total',
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54)),
                    ),
                  ],
                  rows: [
                    for (final item in widget.invoiceData)
                      dataRowForProductInvoiceWidget(item: item),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  dataRowForProductInvoiceWidget({required InvoiceData item}) {
    quantity = TextEditingController(text: item.quantity.toString());
   return DataRow(
      cells: [
        DataCell(Text(item.product_name)),
        DataCell(
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              width: 150,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
              ),
              child: Row(
                mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: ()  {
                      setState(() {
                        qty = int.parse(quantity.text) + 1;
                        // _updateQuantityAndTotal(
                        //     item, qty);
                      });

                    },
                  ),

                  SizedBox(
                    width: 50,
                    height: 30,
                    child: TextFormField(
                      controller: quantity,
                      autofocus: false,
                      onTap: (() {
                        quantity.selection = TextSelection.fromPosition(
                            TextPosition(offset: quantity.text.length));
                        quantity.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: quantity.value.text.length,
                        );
                      }),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () async {
                      setState(() {
                        qty = int.parse(quantity.text) - 1;
                      });
                      if (qty > 0) {
                        _updateQuantityAndTotal(
                            item, qty);
                      }
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
        DataCell(Text(item.sale_price)),
        DataCell(
          Text(
            item.total.toString(),
          ),
        ),
      ],
    );
  }
}
