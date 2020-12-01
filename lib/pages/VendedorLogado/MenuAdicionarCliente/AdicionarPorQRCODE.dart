import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
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
    print("adicionado");
    final String responseString = response.body;
    return responseString;
  } else {
    print(
        "${response.statusCode} ${response.body} \ne cliente $idCliente e vendedor $idVendedor");
    return null;
  }
}

String idCliente = value;
String codeValue, value = "";
var busy = true;

class _MyScanCodeState extends State<MyScanCode> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var _user;
    Future scan() async {
      codeValue = await FlutterBarcodeScanner.scanBarcode(
          "#004297", "Cancelar", true, ScanMode.QR);
      if (codeValue == "-1") {
        idCliente = "";
        idVendedor = "";
      } else {
        setState(() {
          busy = false;
          idCliente = codeValue;
          idVendedor = userId;
        });
      }
    }

    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: busy
                  ? Container()
                  : FlatButton(
                      child: Text("Adicionar Usuario"),
                      onPressed: () async {
                        idCliente = codeValue;
                        idVendedor = userId;
                        final user = await creatUser(idCliente, idVendedor);
                        if (idCliente == null) {
                          return null;
                        } else {
                          setState(() {
                            _user = user;
                            idCliente = "";
                            idVendedor = "";
                            busy = true;
                          });
                        }
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