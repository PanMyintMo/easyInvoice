import 'package:flutter/material.dart';
import 'ButtonWidget.dart';


import 'InvoiceScreen.dart';
import 'TitleWidget.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      title: const Text("Invoice"),
      centerTitle: true,
    ),
    body: Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const TitleWidget(
              icon: Icons.picture_as_pdf,
              text: 'Generate Invoice',
            ),
            const SizedBox(height: 48),
            ButtonWidget(
              text: 'Invoice PDF',
              onClicked: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const InvoiceScreen(

              )));
              },
            ),
          ],
        ),
      ),
    ),
  );
}