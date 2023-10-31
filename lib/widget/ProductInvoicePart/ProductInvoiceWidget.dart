import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../common/FormValidator.dart';
import '../../data/api/ConnectivityService.dart';
import '../../data/api/apiService.dart';
import '../../data/responseModel/DeliveryPart/ProductInvoiceResponse.dart';
import '../../dataRequestModel/DeliveryPart/ProductInvoiceRequest.dart';
import '../../bloc/post/product_invoice_cubit.dart';
import '../../dataRequestModel/DeliveryPart/UpdateQuantityInBarcodeRequest.dart';
import 'PdfPage.dart';

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
  var productNo = TextEditingController();
  final Map<int, int> itemQuantities = {};
  int quantity = 0;

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
      String scannedBarcode = result.toString();
      setState(() {
        productNo.text = scannedBarcode;
      });
    }
  }

  void _handleSearch() {
    if (productNo.text.isNotEmpty) {
      context
          .read<ProductInvoiceCubit>()
          .productInvoice(ProductInvoiceRequest(barcode: productNo.text));
      productNo.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
                    onPressed: widget.invoiceData.isNotEmpty
                        ? () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfPage(),
                              ),
                            );
                          }
                        : null,
                    child: const Text('Print'),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: productNo,
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
                        columns: [
                          DataColumn(
                            label: Text('Product Name',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AdaptiveTheme.of(context)
                                        .theme
                                        .iconTheme
                                        .color)),
                          ),
                          DataColumn(
                            label: Text('QTY',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AdaptiveTheme.of(context)
                                        .theme
                                        .iconTheme
                                        .color)),
                          ),
                          DataColumn(
                            label: Text('Sale Price',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AdaptiveTheme.of(context)
                                        .theme
                                        .iconTheme
                                        .color)),
                          ),
                          DataColumn(
                            label: Text('Total',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AdaptiveTheme.of(context)
                                        .theme
                                        .iconTheme
                                        .color)),
                          ),
                        ],
                        rows: [
                          for (final item in widget.invoiceData)
                            dataRowForProductInvoiceWidget(item: item),
                        ],
                      ),
                    ),
                    if (widget.isLoading)
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

  DataRow dataRowForProductInvoiceWidget({required InvoiceData item}) {
    if (!itemQuantities.containsKey(item.id)) {
      itemQuantities[item.id!] = itemQuantities[item.id] ?? 1; // Initialize with the value from itemQuantities or 0 if not present
    }

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
                      // Increment the local quantity
                      int updatedQuantity = (itemQuantities[item.id] ?? 0) + 1;

                      // Update the server with the new quantity
                      UpdateQuantityBarcodeRequest request = UpdateQuantityBarcodeRequest(
                        quantity: updatedQuantity.toString(),
                        invoice_id: item.id.toString(),
                      );

                      // Perform the API call
                      ApiService(ConnectivityService())
                          .updatedQuantityItemBarcode(request)
                          .then((response) {

                        setState(() {
                          itemQuantities[item.id!] = updatedQuantity;
                          quantity = updatedQuantity;
                          item.total = (quantity * double.parse(item.sale_price!)).toInt();
                        });
                      })
                          .catchError((error) {

                        setState(() {
                          itemQuantities[item.id!] = (itemQuantities[item.id] ?? 0) - 1;
                        });
                      });
                    },
                  ),

                  SizedBox(
                    width: 50,
                    height: 30,
                    child: Text(
                      itemQuantities[item.id].toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      // Calculate the updated local quantity
                      int updatedQuantity = (itemQuantities[item.id] ?? 0) - 1;

                      // Ensure the quantity does not go below 0
                      if (updatedQuantity < 0) {
                        updatedQuantity = 0;
                      }

                      // Update the server with the new quantity
                      UpdateQuantityBarcodeRequest request = UpdateQuantityBarcodeRequest(
                        quantity: updatedQuantity.toString(),
                        invoice_id: item.id.toString(),
                      );

                      // Perform the API call
                      ApiService(ConnectivityService())
                          .updatedQuantityItemBarcode(request)
                          .then((response) {
                            setState(() {
                          itemQuantities[item.id!] = updatedQuantity;
                          quantity = updatedQuantity;
                          item.total = (quantity * double.parse(item.sale_price!)).toInt();
                        });
                      })
                          .catchError((error) {
                        setState(() {
                          itemQuantities[item.id!] = (itemQuantities[item.id] ?? 0) + 1;
                        });
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
          Text(item.total!.toStringAsFixed(2)),
        ),
      ],
    );
  }
}
