import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MyScanCode extends StatefulWidget {
  @override
  _MyScanCodeState createState() => _MyScanCodeState();
}

class _MyScanCodeState extends State<MyScanCode> {
  String codeValue, value = "";

  Future scan() async {
    print(value);
    codeValue = await FlutterBarcodeScanner.scanBarcode(
        "#004297", "Cancelar", true, ScanMode.QR);
    setState(() {
      value = codeValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Center(
              child: Text("Valor do codigo qrcode"),
            ),
            Center(
              child: Text(
                "$value",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: scan,
          child: Icon(Icons.qr_code_scanner, size: 30),
        ));
  }
}
