import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/EsseDTO.dart';
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
    final double altura = MediaQuery.of(context).size.height * 0.08;
    final double largura = MediaQuery.of(context).size.width * 0.06;
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
              if (!snapshot.hasData)
                return Text("meu erro é " + snapshot.error.toString());
              print(snapshot.data);
              final List<MeuDTO> meusClientes = snapshot.data;
              return ListView.builder(
                itemCount: meusClientes.length,
                itemBuilder: (BuildContext context, int index) {
                  MeuDTO _p = meusClientes[index];
                  var vltTotal = _p.campanhaDTO.vlrTotalComprasValorFixo <
                          _p.vlrComprasRealizadas
                      ? _p.vlrComprasRealizadas
                      : _p.campanhaDTO.vlrTotalComprasValorFixo;
                  var contador =
                      _p.campanhaDTO.flgPercentualSobreCompras == false
                          ? _p.vlrComprasRealizadas / vltTotal * 100
                          : _p.qtdComprasRealizadas;
                  double vrCompleted =
                      _p.campanhaDTO.flgPercentualSobreCompras == false
                          ? _p.vlrComprasRealizadas / vltTotal * 100
                          : _p.qtdComprasRealizadas /
                              _p.campanhaDTO
                                  .qtLancamentosPercentualSobreCompras *
                              100;
                  double vrRemaining = 100 - vrCompleted;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Row(
                        children: [
                          Container(
                            child: Center(
                              child: Image.asset("images/pati.png",
                                  fit: BoxFit.cover, height: 150, width: 130),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  new Center(
                                      child: RichText(
                                    text: TextSpan(
                                        text: "${_p.clienteDTO.nome}\n",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Constantes.customColorBlue),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: "(11) 12345-1234",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w300,
                                                  color: Constantes
                                                      .customColorBlue))
                                        ]),
                                  )),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      AnimatedCircularChart(
                                        size: Size(altura, largura),
                                        holeRadius: 20.0,
                                        holeLabel: _p.campanhaDTO
                                                    .flgPercentualSobreCompras ==
                                                false
                                            ? '${contador.toStringAsFixed(0)}%'
                                            : '${contador.toString()}/${_p.campanhaDTO.qtLancamentosPercentualSobreCompras.toString()}',
                                        labelStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                        initialChartData: <CircularStackEntry>[
                                          new CircularStackEntry(
                                            <CircularSegmentEntry>[
                                              new CircularSegmentEntry(
                                                vrCompleted,
                                                Constantes.customColorOrange,
                                                rankKey: 'completed',
                                              ),
                                              new CircularSegmentEntry(
                                                vrRemaining,
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
                                                0.23,
                                        child: Center(
                                          child: Text(
                                              "R\$ " +
                                                  _p.vlrComprasRealizadas
                                                      .toStringAsFixed(2),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      IconButton(
                                          iconSize: 28,
                                          icon: Icon(
                                            Icons.chat,
                                            color: Constantes.customColorOrange,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              idCliente =
                                                  _p.clienteDTO.username;
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
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
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
