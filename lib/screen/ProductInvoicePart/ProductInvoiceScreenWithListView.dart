import 'package:easy_invoice/screen/ProductInvoicePart/ProductInvoiceScreenWithItem.dart';
import 'package:easy_invoice/widget/ProductInvoicePart/PdfPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../common/FormValidator.dart';
import '../../data/responseModel/DeliveryPart/ProductInvoiceResponse.dart';
import '../../dataRequestModel/DeliveryPart/ProductInvoiceRequest.dart';
import '../../bloc/post/product_invoice_cubit.dart';

class ProductInvoiceScreenWithListView extends StatefulWidget {
  final bool isLoading;
  final List<InvoiceData> invoiceData;

  const ProductInvoiceScreenWithListView({
    Key? key,
    required this.isLoading,
    required this.invoiceData,
  }) : super(key: key);

  @override
  State<ProductInvoiceScreenWithListView> createState() => _ProductInvoiceScreenWithListViewState();
}

class _ProductInvoiceScreenWithListViewState extends State<ProductInvoiceScreenWithListView> {
  var prouductno = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  bool isClick = false;
  int quantity = 0;

  @override
  void initState() {
    super.initState();
  }

  // void _checkInput() {
  //   setState(() {
  //     isClick = prouductno.text.isNotEmpty;
  //   });
  // }

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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PdfPage()));
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
               Expanded(
                 child: SingleChildScrollView(
                  child: Column(
                    children:  [
                      const Row(
                        children: [
                          Text('Product Name',
                                style:
                                TextStyle(fontSize: 16, color: Colors.black54)),
                          Text('QTY',
                                style:
                                TextStyle(fontSize: 16, color: Colors.black54)),
                          Text('Sale Price',
                                style:
                                TextStyle(fontSize: 16, color: Colors.black54)),
                          Text('Total',
                                style:
                                TextStyle(fontSize: 16, color: Colors.black54)),
                        ],
                      ),
                      Expanded(
                        child: buildListView(widget.invoiceData),
                      )
                    ],
                  ),
              ),
               )
            ],
          ),
        ],
      ),
    );
  }

  buildListView(List<InvoiceData> invoiceList){
     return ListView.builder(
         itemCount: invoiceList.length,
         itemBuilder: (context,index){
        return ProductInvoiceScreenWithItem(item: invoiceList[index]);
     });
  }

}
