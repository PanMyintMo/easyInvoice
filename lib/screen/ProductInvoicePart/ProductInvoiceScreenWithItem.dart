import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/responsemodel/DeliveryPart/ProductInvoiceResponse.dart';
import 'package:easy_invoice/dataRequestModel/DeliveryPart/UpdateQuantityInBarcodeRequest.dart';
import 'package:flutter/material.dart';

class ProductInvoiceScreenWithItem extends StatefulWidget {
  final InvoiceData item;
  const ProductInvoiceScreenWithItem({super.key,required this.item});

  @override
  State<ProductInvoiceScreenWithItem> createState() => _ProductInvoiceScreenWithItemState();
}


class _ProductInvoiceScreenWithItemState extends State<ProductInvoiceScreenWithItem> {
  var prouductno = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  bool isClick = false;
  int quantity = 0;


  @override
  void initState() {
    // TODO: implement initState
    quantityController.text = widget.item.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.item.product_name!),
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
                      ApiService()
                          .updatedQuantityItemBarcode(
                        UpdateQuantityBarcodeRequest(
                          quantity: (quantity + 1).toString(),
                          invoice_id: widget.item.id.toString(),
                        ),
                      )
                          .then((response) {
                        setState(() {
                          quantity = quantity + 1;
                          widget.item.total = (quantity * double.parse(widget.item.sale_price!))
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
                      ApiService()
                          .updatedQuantityItemBarcode(
                        UpdateQuantityBarcodeRequest(
                          quantity: (quantity - 1).toString(),
                          invoice_id: widget.item.id.toString(),
                        ),
                      )
                          .then((response) {
                        setState(() {
                          quantity--;
                          widget.item.total = (quantity * double.parse(widget.item.sale_price!))
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
        Text(widget.item.sale_price!),
        Text(
            widget.item.total.toString(),
          ),
      ],
    );
  }
}
