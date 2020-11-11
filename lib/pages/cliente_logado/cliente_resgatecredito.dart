import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/contaDTO.dart';
import 'package:migrou_app/pages/DashCliente.dart';

String nomeStabelecimento;
String nomeSegimento;
String nomeTelefone;
String nomeFotoStabelecimento;
String nomeIdVendedor;

class ResgateCredito extends StatefulWidget {
  @override
  _ResgateCreditoState createState() => _ResgateCreditoState();
}

class _ResgateCreditoState extends State<ResgateCredito> {
  @override
  Widget build(BuildContext context) {
    final PessoaWebClient httpServer = PessoaWebClient();
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecione um Vendedor"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: httpServer.vendedoresVinculadosAoCliente(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) return Center(child: Text("ops..."));
              final List<PessoaDTOnew> meusgetInfo = snapshot.data;
              return ListView.builder(
                itemCount: meusgetInfo.length,
                itemBuilder: (BuildContext context, int index) {
                  PessoaDTOnew _i = meusgetInfo[index];
                  String profileIMG = _i.base64Foto;
                  Uint8List bytes = base64.decode(profileIMG);
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _i.base64Foto == null || _i.base64Foto == ""
                                    ? Image.asset("images/no-image-default.png",
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 80)
                                    : Image.memory(bytes,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 80),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: ListTile(
                                            title: Text(
                                              _i.nomeNegocio,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              "${_i.segmentoComercial}\n${_i.nrCelular}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                              child: Container(
                                                  height: 30,
                                                  width: 130,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                      child: Text(
                                                        "Crédito/Resgate",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  )),
                                              onTap: () {
                                                setState(() {
                                                  nomeStabelecimento =
                                                      _i.nomeNegocio;
                                                  nomeSegimento =
                                                      _i.segmentoComercial;
                                                  nomeTelefone = _i.nrCelular;
                                                  nomeFotoStabelecimento =
                                                      _i.base64Foto;
                                                  nomeIdVendedor = _i.id;
                                                });
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DashCliente()),
                                                );
                                              }),
                                        )
                                      ]),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
