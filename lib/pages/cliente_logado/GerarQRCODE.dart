import 'package:flutter/material.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQrcode extends StatefulWidget {
  @override
  _MyQrcodeState createState() => _MyQrcodeState();
}

class _MyQrcodeState extends State<MyQrcode> {
  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu QRCODE"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: QrImage(
              data: "$userId",
              version: QrVersions.auto,
              size: 200.0,
              gapless: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                .copyWith(bottom: 40),
            child: Text(
                "Mostre o seu código para se vincular a um estabeleciamento."),
          ),
        ],
      ),
    );
  }
}
