import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/widget/ProductInvoicePart/PdfPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../common/FormValidator.dart';
import '../../data/api/ConnectivityService.dart';
import '../../data/responseModel/DeliveryPart/ProductInvoiceResponse.dart';
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
  final TextEditingController quantityController = TextEditingController();
  bool isClick = false;
  int quantity = 0;



  @override
  void initState() {
    super.initState();
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
      prouductno.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title:  Text(
          'Product Invoice',
          style: TextStyle(
            color: AdaptiveTheme.of(context).theme.iconTheme.color,

          ),
        ),
        actions: [
          TextButton(
            onPressed: barcodeScanner,
            child: const Icon(
              Icons.qr_code_scanner,
              size: 24,
              weight: 50.0,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: widget.invoiceData.isNotEmpty ? () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfPage(),
                        ),
                      );
                    } : null,
                    child: const Text('Print'),
                  )

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
                Stack(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns:  [
                          DataColumn(
                            label: Text('Product Name',
                                style:
                                    TextStyle(fontSize: 16, color:AdaptiveTheme.of(context).theme.iconTheme.color)),
                          ),
                          DataColumn(
                            label: Text('QTY',
                                style:
                                    TextStyle(fontSize: 16, color: AdaptiveTheme.of(context).theme.iconTheme.color)),
                          ),
                          DataColumn(
                            label: Text('Sale Price',
                                style:
                                    TextStyle(fontSize: 16, color: AdaptiveTheme.of(context).theme.iconTheme.color)),
                          ),
                          DataColumn(
                            label: Text('Total',
                                style:
                                    TextStyle(fontSize: 16, color: AdaptiveTheme.of(context).theme.iconTheme.color)),
                          ),
                        ],
                        rows: [
                          for (final item in widget.invoiceData)
                            dataRowForProductInvoiceWidget(item: item),
                        ],
                      ),
                    ),

                    if(widget.isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  dataRowForProductInvoiceWidget({required InvoiceData item}) {
    return DataRow(
      cells: [
        DataCell(Text(item.product_name!)),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      ApiService(ConnectivityService())
                          .updatedQuantityItemBarcode(
                        UpdateQuantityBarcodeRequest(
                          quantity: (quantity + 1).toString(),
                          invoice_id: item.id.toString(),
                        ),
                      )
                          .then((response) {
                        setState(() {
                          quantity = quantity + 1;
                          item.total = (quantity * double.parse(item.sale_price!))
                              .toInt();

                          // Update the controller's text property
                          quantityController.text = quantity.toString();
                        });
                      }).catchError((error) {
                        // Handle the API call error
                      });
                    },
                  ),
                  SizedBox(
                    width: 50,
                    height: 30,
                    child: TextFormField(
                      controller: quantityController,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      ApiService(ConnectivityService())
                          .updatedQuantityItemBarcode(
                        UpdateQuantityBarcodeRequest(
                          quantity: (quantity - 1).toString(),
                          invoice_id: item.id.toString(),
                        ),
                      )
                          .then((response) {
                        setState(() {
                          quantity--;
                          item.total = (quantity * double.parse(item.sale_price!))
                              .toInt();

                          quantityController.text = quantity.toString();
                        });
                      }).catchError((error) {
                        // Handle the API call error
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        DataCell(Text(item.sale_price!)),
        DataCell(
          Text(
           item.total.toString(),
          ),
        ),
      ],
    );
  }
}
