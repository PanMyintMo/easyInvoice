import 'dart:async';
import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'InvoiceResponse/Invoice.dart';
import '../../widget/ProductInvoicePart/printerenum.dart';

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

  Future<void> printText(List<IData> invoice) async {
    try {
      await bluetoothPrint.connect(_device!);
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);

      List<int> bytes = [];

      for (var data in invoice) {
        ByteData bytesAsset = await rootBundle.load("assets/invoice.png");
       final imageBytesFromAsset= bytesAsset.buffer.asUint8List(bytesAsset.offsetInBytes, bytesAsset.lengthInBytes);


        // Print the image to the right of the paper
        bluetoothPrint.printImageBytes(imageBytesFromAsset);

        await bluetoothPrint.printNewLine();

        bluetoothPrint.printLeftRight("LEFT", "RIGHT", Size.bold.val,
            format:
            "%-15s %15s %n");

        await bluetoothPrint.printNewLine();

        // Adding header text
        bluetoothPrint.printCustom(
            "MMEasyInvoice", Size.boldMedium.val, Aligns.center.val);
        bluetoothPrint.printNewLine();

        bluetoothPrint.printCustom(
            "09798217582", Size.boldMedium.val, Aligns.center.val);
        bluetoothPrint.printNewLine();
        bluetoothPrint.print3Column(
            "Client Name", "", "ITVisionHub Co.ltd;", Size.bold.val,
            format: "%-10s %10s %10s %n");
        await bluetoothPrint.printNewLine();

        bluetoothPrint.print3Column(
            "Sayar Yan Aung", "", "ITVisionHub Co.ltd;", Size.bold.val,
            format: "%-10s %10s %10s %n");
        await bluetoothPrint.printNewLine();

        bluetoothPrint.print4Column(
            "Product Name", "Price", "Quantity", "Total", Size.bold.val,
            format: "%-10s %10s %10s %10s %n");
        await bluetoothPrint.printNewLine();

        bluetoothPrint.print4Column(
            "${data.product_name}",
            "${data.sale_price}",
            "${data.quantity}",
            "${data.total}",
            Size.bold.val,
            format: "%-10s %10s %10s %10s %n");

        bluetoothPrint.printNewLine();

        bluetoothPrint.printCustom("Thank You Choosing Our Service!", Size.bold.val, Aligns.center.val);



        bytes += generator.hr();
        generator.cut();

        // Writing bytes to the printer
        await bluetoothPrint.writeBytes(Uint8List.fromList(bytes));

        // Printing a new line
        await bluetoothPrint.printNewLine();

        // Disconnecting from the printer
        await bluetoothPrint.disconnect();
      }
    } catch (e) {
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
              printText(widget.invoice);
            },
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Text(tips),
                ),
                const Divider(),
                const SizedBox(
                  height: 50,
                ),
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
                          const SizedBox(
                            width: 20,
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
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
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
        ],
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
        tips = "Device is connected";
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
