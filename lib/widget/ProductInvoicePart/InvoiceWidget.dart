import 'dart:async';
import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'InvoiceResponse/Invoice.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

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
  BlueThermalPrinter bluetoothPrint = BlueThermalPrinter.instance;

  bool _connected = false;
  List<BluetoothDevice>? _devices = [];
  BluetoothDevice? _device;
  String tips = 'No device connected';

  @override
  void initState() {
    super.initState();
    initBluetooth();
  }

  Future<void> initBluetooth() async {
    bool? isConnected = await bluetoothPrint.isConnected;

    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetoothPrint.getBondedDevices();
    } on PlatformException {
      // print("Platform error");
    }

    bluetoothPrint.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            tips = "Bluetooth device is connected";
          });
          break;

        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = "Bluetooth device is disconnected";
          });
          break;

        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            _connected = false;
            tips = "Bluetooth device disconnect requested";
          });
          break;

        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {
            _connected = false;
            tips = "Bluetooth device STATE_TURNING_OFF";
          });
          break;

        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            _connected = false;
            tips = "Bluetooth device Not Connected";
          });
          break;

        case BlueThermalPrinter.STATE_ON:
          setState(() {
            _connected = false;
            tips = "Bluetooth device Connect";
          });
          break;

        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            _connected = false;
            tips = "Bluetooth device STATE_TURNING_ON";
          });
          break;

        case BlueThermalPrinter.ERROR:
          setState(() {
            _connected = false;
            tips = "Bluetooth device error";
          });
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected == true) {
      setState(() {
        _connected = true;
      });
    }
  }

  Future<void> printImage(Uint8List imageBytes) async {
    if (_connected) {
      await bluetoothPrint.connect(_device!);
      await bluetoothPrint.printImageBytes(imageBytes);
      await bluetoothPrint.printNewLine();
      await bluetoothPrint.disconnect();
    }
  }

  Future<void> printText(List<IData> invoice) async {

    try {
    await bluetoothPrint.connect(_device!);
        final profile = await CapabilityProfile.load();
        final generator = Generator(PaperSize.mm58, profile);

        List<int> bytes = [];


    bytes += generator.text("MMEasyInvoice");
    bytes +=generator.text("Xiao Pan");
        for (var item in invoice) {
          bytes +=generator.row([
            PosColumn(
                text: item.product_name!,width: 5,
                styles: PosStyles(
                    align: PosAlign.left,
                    height: PosTextSize.size1
                    ,width: PosTextSize.size1
                )
            ),
            PosColumn(
                text: item.quantity.toString()
                ,width: 5,
                styles: PosStyles(
                    align: PosAlign.left,
                    height: PosTextSize.size1
                    ,width: PosTextSize.size1
                )
            ),
            PosColumn(
                text: item.sale_price!,width: 5,
                styles: PosStyles(
                    align: PosAlign.left,
                    height: PosTextSize.size1
                    ,width: PosTextSize.size1
                )
            )
            ,PosColumn(
                text: item.total.toString(),width: 5,
                styles: PosStyles(
                    align: PosAlign.left,
                    height: PosTextSize.size1
                    ,width: PosTextSize.size1
                )
            )
          ]

          );


        /*  bytes.addAll(generator.text(
            "${item.product_name}",
            styles: const PosStyles(
              align: PosAlign.left,
              bold: true,
              height: PosTextSize.size2,
              width: PosTextSize.size2,
            ),
          ));*/

        }
        bytes+= generator.hr();

        bytes.addAll(generator.cut());


        await bluetoothPrint.writeBytes(Uint8List.fromList(bytes));

        await bluetoothPrint.printNewLine();


        await bluetoothPrint.disconnect();
      }

     catch (e) {
      print("Printing error: $e");
    }
  }

  Future<void> generateAndPrintPdf() async {
    try {
      final pdfDoc = pw.Document();
      pdfDoc.addPage(
        pw.MultiPage(
          build: (context) => [
            buildHeader(),
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
      final pdfAsUint8List = await pdfDoc.save();
     // final pdfContent = String.fromCharCodes(pdfAsUint8List);
      /*print('PDF Content: $pdfContent');
      print(" Pdf Unit 8 List $pdfAsUint8List");
      print("Data to print: ${widget.invoice}");*/

           if (_connected) {
        await bluetoothPrint.connect(_device!);
        await bluetoothPrint.writeBytes(pdfAsUint8List);
        await bluetoothPrint.printNewLine();
        await bluetoothPrint.disconnect();
      }
    } catch (e) {
     // print("Printing error in pdf file $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
        actions: <Widget>[
          IconButton(
            icon: _connected
                ? const Icon(Icons.print)
                : const Icon(Icons.print_disabled),
            onPressed: () {
              // final ByteData data = await rootBundle.load("assets/invoice.png");
              // final Uint8List imageBytes = data.buffer.asUint8List();
              // await  printImage(imageBytes);
             //  generateAndPrintPdf();

              printText(widget.invoice);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Text(tips),
                ),
              ],
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Device:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: DropdownButton(
                          items: _getDeviceItems(),
                          onChanged: (BluetoothDevice? value) =>
                              setState(() => _device = value),
                          value: _device,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown),
                        onPressed: () {
                          initBluetooth();
                        },
                        child: const Text(
                          'Refresh',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                            _connected ? Colors.red : Colors.green),
                        onPressed: _connected ? _disconnect : _connect,
                        child: Text(
                          _connected ? 'Disconnect' : 'Connect',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            if (_connected)
              ElevatedButton(
                onPressed: () {
                   generateAndPrintPdf();
                },
                child: const Text("Print Preview"),
              ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices!.isEmpty) {
      items.add(const DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices?.forEach((device) {
        items.add(DropdownMenuItem(
          value: device,
          child: Text(device.name ?? ""),
        ));
      });
    }
    return items;
  }

  void _connect() {
    if (_device != null) {
      setState(() {
        tips = "Device is connecting...";
        _connected = true;
      });

      bluetoothPrint.isConnected.then((isConnected) {
        if (isConnected == true) {
          bluetoothPrint.connect(_device!).catchError((error) {
            setState(() => _connected = false);
          });
        }
      });
    } else {}
  }

  void _disconnect() {
    bluetoothPrint.disconnect();
    setState(() => _connected = false);
  }

  pw.Widget buildHeader() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // pw.SizedBox(height: 1 * PdfPageFormat.cm),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text("Xiao Pan"),
            pw.Text("MyanmarEasyInvoice"),
          ],
        ),
        //   pw.SizedBox(height: 1 * PdfPageFormat.cm),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            // Add content for the customer address and invoice info as needed
          ],
        ),
      ],
    );
  }

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
