import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/http/webclient.dart';
import 'package:migrou_app/model/contaDTO.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/utils/definicoes.dart';

class Capivara extends StatefulWidget {
  @override
  _CapivaraState createState() => _CapivaraState();
}

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
  final response = await client.patch(urlAPI, headers: headers, body: body);

  if (response.statusCode == 200) {
    print("adicionado");
    final String responseString = response.body;
    return AlertDialog(title: Text(responseString));
  } else {
    print(
        "${response.statusCode} ${response.body} \ne cliente $idCliente e vendedor $idVendedor");
    return AlertDialog(title: Text("${response.body}"));
  }
}

class _CapivaraState extends State<Capivara> {
  @override
  Widget build(BuildContext context) {
    final PessoaWebClient httpServices = PessoaWebClient();
    return Scaffold(
        appBar: AppBar(title: Text("Adicionar Cliente")),
        body: FutureBuilder(
          future: httpServices.localizarPorEmail(),
          builder: (_, AsyncSnapshot<PessoaDTOnew> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData)
                return Center(child: Text("Verifique sua Conexão!"));
              String profileIMG = snapshot.data.base64Foto;
              Uint8List bytes = base64.decode(profileIMG);
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      profileIMG == null || profileIMG == ""
                          ? Container(
                              width: 80,
                              height: 120,
                              child: Image.asset('images/no-image-default.png'),
                            )
                          : Container(
                              width: 80,
                              height: 120,
                              child: Image.memory(
                                bytes,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Text("Nome: ${snapshot.data.nome}"),
                      SizedBox(height: 10),
                      Text("Data Nascimento: ${snapshot.data.dataNascimento}"),
                      SizedBox(height: 10),
                      Text("E-mail: ${snapshot.data.email}"),
                      SizedBox(width: 10),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            idVendedor = userId;
                            idCliente = snapshot.data.id;
                            creatUser(idCliente, idVendedor);
                          });
                        },
                        child: Text("Adicinar"),
                      )
                    ]),
              );
            } else {
              return Column(
                children: [
                  Center(child: CircularProgressIndicator()),
                  Center(
                    child: Text("Aguarde..."),
                  )
                ],
              );
            }
          },
        ));
  }
}
