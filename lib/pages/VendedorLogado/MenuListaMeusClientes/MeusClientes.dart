import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/contaDTO.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/pages/VendedorLogado/ChatPage.dart/VendedorChatPage.dart';
import 'package:migrou_app/utils/definicoes.dart';

class VinculadosClientes extends StatefulWidget {
  @override
  _VinculadosClientesState createState() => _VinculadosClientesState();
}

class _VinculadosClientesState extends State<VinculadosClientes> {
  @override
  Widget build(BuildContext context) {
    final PessoaWebClient httpServer = PessoaWebClient();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Meus Clientes"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: httpServer.meusClientesDASH(),
          builder: (_, snapshot) {
            // print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData) return Text(snapshot.error.toString());
              // print(snapshot.data);
              final List<CashBackDTO> meusClientes = snapshot.data;
              return ListView.builder(
                itemCount: meusClientes.length,
                itemBuilder: (BuildContext context, int index) {
                  CashBackDTO _p = meusClientes[index];
                  String profileIMG = _p.clienteDTO.pessoaDTO.base64Foto;
                  Uint8List bytes = base64.decode(profileIMG);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Row(
                        children: [
                          _p.clienteDTO.pessoaDTO.base64Foto == null ||
                                  _p.clienteDTO.pessoaDTO.base64Foto == ""
                              ? Container(
                                  child: Center(
                                    child: Image.asset(
                                        "images/no-image-default.png",
                                        fit: BoxFit.cover,
                                        height: 150,
                                        width: 130),
                                  ),
                                )
                              : Container(
                                  child: Center(
                                    child: Image.memory(bytes,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 80),
                                  ),
                                ),
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  new ListTile(
                                    title: Text(_p.clienteDTO.pessoaDTO.nome),
                                    subtitle:
                                        Text(_p.clienteDTO.pessoaDTO.email),
                                  ),
                                  Row(
                                    children: [
                                      AnimatedCircularChart(
                                        size: Size(90, 70),
                                        holeRadius: 20.0,
                                        holeLabel: "5/5",
                                        labelStyle: TextStyle(
                                            fontSize: 24,
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                        initialChartData: <CircularStackEntry>[
                                          new CircularStackEntry(
                                            <CircularSegmentEntry>[
                                              new CircularSegmentEntry(
                                                50,
                                                Constantes.customColorOrange,
                                                rankKey: 'completed',
                                              ),
                                              new CircularSegmentEntry(
                                                50,
                                                Constantes.customColorCinza,
                                                rankKey: 'remaining',
                                              ),
                                            ],
                                            rankKey: 'progress',
                                          ),
                                        ],
                                        chartType: CircularChartType.Radial,
                                        edgeStyle: SegmentEdgeStyle.round,
                                        percentageValues: true,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Center(
                                          child: Text(
                                              _p.vlrComprasRealizadas
                                                  .toStringAsFixed(2),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.chat,
                                            color: Constantes.customColorOrange,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              idCliente =
                                                  _p.clienteDTO.pessoaDTO.id;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VendedorChatePage(
                                                        idCliente: idCliente,
                                                        userId: userId,
                                                      )),
                                            );
                                          })
                                    ],
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
