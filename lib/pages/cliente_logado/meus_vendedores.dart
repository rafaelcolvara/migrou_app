import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/contaDTO.dart';
import 'package:migrou_app/utils/definicoes.dart';

class VinculadosVendedores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PessoaWebClient pessoaWebClient = PessoaWebClient();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Meus Vendedores"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: pessoaWebClient.vendedoresVinculadosAoCliente(),
          builder: (_, snapshot) {
            // print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData)
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(child: Text('Nenhum')),
                    Center(
                      child: Text("VENDEDOR VINCULADO!"),
                    ),
                  ],
                );
              // print(snapshot.data);
              final List<PessoaDTOnew> meusClientes = snapshot.data;
              return ListView.builder(
                itemCount: meusClientes.length,
                itemBuilder: (BuildContext context, int index) {
                  PessoaDTOnew _p = meusClientes[index];
                  String profileIMG = _p.base64Foto;
                  Uint8List bytes = base64.decode(profileIMG);
                  var ddd = _p.nrCelular.substring(0, 2);
                  var teleP1 = _p.nrCelular.substring(2, 7);
                  var teleP2 = _p.nrCelular.substring(7, 11);
                  return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _p.base64Foto == null || _p.base64Foto == ""
                                      ? Container(
                                          width: 80,
                                          height: 120,
                                          child: Image.asset(
                                              'images/no-image-default.png'),
                                        )
                                      : Container(
                                          width: 80,
                                          height: 120,
                                          child: Image.memory(
                                            bytes,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new ListTile(
                                        title: Text(
                                          _p.nomeNegocio,
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(_p.segmentoComercial),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.alternate_email,
                                              color:
                                                  Constantes.customColorOrange),
                                          SizedBox(width: 2),
                                          Text(_p.email),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.phone_android,
                                            color: Constantes.customColorOrange,
                                          ),
                                          SizedBox(width: 2),
                                          Text("($ddd) $teleP1-$teleP2")
                                        ],
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
