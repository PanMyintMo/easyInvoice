import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'ImageBuilder.dart';
import 'InvoiceResponse/Invoice.dart';

class InvoiceWidget extends StatefulWidget {
  final List<IData> invoice;
  final bool isLoading;

  const InvoiceWidget({
    Key? key,
    required this.invoice,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<InvoiceWidget> createState() => _InvoiceWidgetState();
}

class _InvoiceWidgetState extends State<InvoiceWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Invoice",
          style: TextStyle(fontSize: 25.00, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Divider(),
        const Align(
          alignment: Alignment.topRight,
          child: ImageBuilder(
            imagePath: "assets/profits.png",
            imgWidth: 200,
            imgHeight: 200,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Thanks for choosing our service!",
          style: TextStyle(color: Colors.grey, fontSize: 15.00),
        ),
        const SizedBox(height: 10),
        const Text(
          "Contact the branch for any clarifications.",
          style: TextStyle(color: Colors.grey, fontSize: 15.00),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _createAndPrintPdf(widget.invoice)
                    // Call the function to start scanning
                  ,
                  child: const Center(child: Text('Generate and Print PDF')),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

Future<void> _createAndPrintPdf(List<IData> invoice) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      build: (context) =>
      [
        buildHeader(widget.invoice),
        buildInvoice(widget.invoice),
        pw.SizedBox(height: 100),
        pw.Divider(),
        pw.Align(
          alignment: pw.Alignment.bottomCenter,
          child: pw.Text("Thanks for choosing our service."),
        ),
      ],
    ),
  );

 await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}

pw.Widget buildHeader(List<IData> invoices) =>
    pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text("Xiao Zhan is Pan Myint Mo's husband."),
            pw.Text("MyanmarEasyInvoice"),
            // Add content for the header as needed
          ],
        ),
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            // Add content for the customer address and invoice info as needed
          ],
        ),
      ],
    );

pw.Widget buildInvoice(List<IData> invoice) {
  final headers = ['Product name', 'Qty', 'Sale Price', 'Total'];
  final data = invoice.map((item) {
    return [
      '${item.product_name}',
      '${item.quantity}',
      '${item.sale_price}',
      '${item.total}'
    ];
  }).toList();

  return pw.Table.fromTextArray(
    data: data,
    headers: headers,
    headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
    headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
    cellHeight: 30,
    cellAlignments: {
      0: pw.Alignment.centerLeft,
      1: pw.Alignment.centerRight,
      2: pw.Alignment.centerRight,
      3: pw.Alignment.centerRight,
    },
  );
}
}
