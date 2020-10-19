import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/pages/vendedor_logado/VendedorLogado.dart';
import 'package:migrou_app/utils/definicoes.dart';
import 'package:http/http.dart' as http;

class MyScanCode extends StatefulWidget {
  @override
  _MyScanCodeState createState() => _MyScanCodeState();
}

//obs falta ajustar essa parte, foi feito assim para teste.
Future creatUser(String idCliente, String idVendedor) async {
  final headers = {
    "Accept": "application/json",
    'Content-Type': 'application/json',
    'userSession': Constantes.TOKEN_ID
  };
  final body = jsonEncode({
    "cliente": {"idCliente": idCliente},
    "vendedor": {"idVendedor": idVendedor}
  });
  final String urlAPI = "${Constantes.HOST_DOMAIN}/vendedor/vinculaCliente";
  final response = await http.patch(urlAPI, headers: headers, body: body);

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return responseString;
  } else {
    print("${response.statusCode} e cliente $idCliente e vendedor $idVendedor");
    return null;
  }
}

String idCliente = value;
String codeValue, value = "";

class _MyScanCodeState extends State<MyScanCode> {
  Future scan() async {
    codeValue = await FlutterBarcodeScanner.scanBarcode(
        "#004297", "Cancelar", true, ScanMode.QR);
    setState(() {
      idCliente = codeValue;
      idVendedor = userId;
    });
  }

  // ignore: unused_field
  var _user;

  @override
  void dispose() {
    super.dispose();
  }

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
                "$idCliente \n $idVendedor",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Center(
              child: FlatButton(
                child: Text("Adicionar Usuario"),
                onPressed: () async {
                  idCliente = codeValue;
                  idVendedor = userId;
                  final user = await creatUser(idCliente, idVendedor);
                  setState(() {
                    _user = user;
                    idCliente = "";
                    idVendedor = "";
                  });
                },
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
