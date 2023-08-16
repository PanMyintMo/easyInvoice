import 'package:easy_invoice/data/api/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../common/FormValidator.dart';
import '../../data/responsemodel/DeliveryPart/ProductInvoiceResponse.dart';
import '../../data/responsemodel/DeliveryPart/UpdateQuantityBarcodeResponse.dart';
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

  @override
  void initState() {
    super.initState();
    prouductno.addListener(_checkInput);
  }

  void _checkInput() {
    setState(() {
      isClick = prouductno.text.isNotEmpty;
    });
  }

  Future<void> barcodeScanner() async {
    try {
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
    } catch (e) {
      print("Error during barcode scanning: $e");
    }
  }

  void _handleSearch() {
    if (prouductno.text.isNotEmpty) {
      context
          .read<ProductInvoiceCubit>()
          .productInvoice(ProductInvoiceRequest(barcode: prouductno.text));

      // Clear the text field after using the entered value
      prouductno.clear();
    }
  }

  Future<void> updateQuantity(UpdateQuantityBarcodeRequest request) async {
    try {
      List<UpdateQuantity> response =
          await ApiService().updatedQuantityItemBarcode(request);

      if (response.isNotEmpty) {
        setState(() {
          final updatedItemIndex = widget.invoiceData
              .indexWhere((item) => item.id == request.invoice_id);
          if (updatedItemIndex != -1) {
            final updatedItem = widget.invoiceData[updatedItemIndex];
            updatedItem.quantity = int.parse(request.quantity);
            updatedItem.total =
                (double.parse(updatedItem.salePrice) * updatedItem.quantity)
                    .toInt();
            widget.invoiceData[updatedItemIndex] = updatedItem;
          }
        });
      }
    } catch (e) {
      print("Error $e");
    }
  }

  // void _handleAddClick(InvoiceData item) {
  //   setState(() {
  //     final index = widget.invoiceData.indexOf(item);
  //     if (index != -1) {
  //       widget.invoiceData[index].quantity++;
  //     }
  //   });
  // }
  //
  // void _handleRemoveClick(InvoiceData item) {
  //   setState(() {
  //     final index = widget.invoiceData.indexOf(item);
  //     if (index != -1 && widget.invoiceData[index].quantity > 0) {
  //       widget.invoiceData[index].quantity--;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed:  barcodeScanner,
                child: const Text("Scan barcode"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: isClick
                    ? () {
                        // Handle print button click
                      }
                    : null,
                child: const Text('Print'),
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
                          style: TextStyle(
                              fontSize: 16, color: Colors.black54)),
                    ),
                    DataColumn(
                      label: Text('QTY',
                          style: TextStyle(
                              fontSize: 16, color: Colors.black54)),
                    ),
                    DataColumn(
                      label: Text('Sale Price',
                          style: TextStyle(
                              fontSize: 16, color: Colors.black54)),
                    ),
                    DataColumn(
                      label: Text('Total',
                          style: TextStyle(
                              fontSize: 16, color: Colors.black54)),
                    ),
                  ],
                  rows: widget.invoiceData.map((item) {
                    return DataRow(
                      cells: [
                        DataCell(Text(item.productName)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () => updateQuantity(
                                        UpdateQuantityBarcodeRequest(
                                            quantity: (item.quantity + 1)
                                                .toString(),
                                            invoice_id:
                                                item.id.toString())),
                                  ),
                                  Text(
                                    item.quantity.toString(),
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () => updateQuantity(
                                        UpdateQuantityBarcodeRequest(
                                            quantity: (item.quantity - 1)
                                                .toString(),
                                            invoice_id:
                                                item.id.toString())),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        DataCell(Text(item.salePrice)),
                        DataCell(
                          Text(
                            item.total.toString(),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
