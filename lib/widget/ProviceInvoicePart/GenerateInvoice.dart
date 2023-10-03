import 'dart:typed_data';
import 'package:easy_invoice/widget/ProviceInvoicePart/InvoiceResponse/Invoice.dart';
import 'package:pdf/widgets.dart' as pw;



Future<Uint8List> generateInvoicePdf(Invoice invoice) async {
  final pdf = pw.Document();

  // Add content to the PDF (replace this with your invoice content)
  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Center(
          child: pw.Text('Your Invoice Content Goes Here'),
        );
      },
    ),
  );

  // Save the PDF to a file (you can also return it as Uint8List)
  final pdfBytes = await pdf.save();

  return pdfBytes;
}
