import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/ClienteDashDTO.dart';
import 'package:migrou_app/model/contaDTO.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/utils/definicoes.dart';

class TelaCliente extends StatefulWidget {
  const TelaCliente({Key key, this.clienteDashDTO, this.teste})
      : super(key: key);

  final ClienteDashDTO clienteDashDTO;
  final String teste;

  @override
  _TelaClienteState createState() => _TelaClienteState();
}

class _TelaClienteState extends State<TelaCliente> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PessoaWebClient httpService = new PessoaWebClient();
    var myDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
    // String texto = """**Faltam** """ +
    //     widget.teste +
    //     """ compras para você ter __10%__ de desconto nas próximas compras. """;
    return Scaffold(
      body: FutureBuilder(
        future: httpService.saldoResgate(),
        builder: (_, AsyncSnapshot<CashBackDTO> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData)
              return Center(child: Text("Dados\nIndisponíveis"));

            var vltTotal = snapshot.data.campanhaDTO.vlrTotalComprasValorFixo <
                    snapshot.data.vlrComprasRealizadas
                ? snapshot.data.vlrComprasRealizadas
                : snapshot.data.campanhaDTO.vlrTotalComprasValorFixo;
            var contador =
                snapshot.data.campanhaDTO.flgPercentualSobreCompras == false
                    ? snapshot.data.vlrComprasRealizadas / vltTotal * 100
                    : snapshot.data.qtdComprasRealizadas;
            double vrCompleted =
                snapshot.data.campanhaDTO.flgPercentualSobreCompras == false
                    ? snapshot.data.vlrComprasRealizadas / vltTotal * 100
                    : snapshot.data.qtdComprasRealizadas /
                        snapshot.data.campanhaDTO
                            .qtLancamentosPercentualSobreCompras *
                        100;
            double vrRemaining = 100 - vrCompleted;
            return ListView(children: <Widget>[
              SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 10),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 80,
                      minHeight: 80,
                      maxHeight: 180,
                      maxWidth: 150,
                    ),
                    child: snapshot.data.vendedorDTO.urlFoto == null
                        ? Image.asset(
                            'image/no-image-default.png',
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            snapshot.data.vendedorDTO.urlFoto,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          snapshot.data.vendedorDTO.nomeNegocio,
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.blueAccent),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "Atividade: ${snapshot.data.vendedorDTO.nomeSegmento}",
                          style: TextStyle(
                              fontSize: 14.0, fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        // Text('email: ' + snapshot.data.vendedorDTO.idVendedor)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: new AnimatedCircularChart(
                          key: _chartKey,
                          size: Size(150.0, 150.0),
                          holeRadius: 50.0,
                          holeLabel: snapshot.data.campanhaDTO
                                      .flgPercentualSobreCompras ==
                                  false
                              ? '${contador.toStringAsFixed(0)}%'
                              : '${contador.toString()}/${snapshot.data.campanhaDTO.qtLancamentosPercentualSobreCompras.toString()}',
                          labelStyle: TextStyle(
                              fontSize: 24,
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
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Valor gasto até: $myDate'),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              ("R\$${(snapshot.data.vlrComprasRealizadas.toStringAsFixed(2))}"),
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            RichText(
                              text: TextSpan(
                                  text:
                                      "${snapshot.data.campanhaDTO.nomeCampanha}.",
                                  style: TextStyle(
                                      color: Constantes.customColorBlue)),
                            )
                            // MarkdownBody(data: texto),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: <Widget>[
                      snapshot.data.campanhaDTO.flgPercentualSobreCompras ==
                                      false &&
                                  snapshot.data.vlrComprasRealizadas >=
                                      snapshot.data.campanhaDTO
                                          .vlrTotalComprasValorFixo ||
                              snapshot.data.campanhaDTO
                                          .flgPercentualSobreCompras ==
                                      true &&
                                  snapshot.data.qtdComprasRealizadas >=
                                      snapshot.data.campanhaDTO
                                          .qtLancamentosPercentualSobreCompras
                          ? RaisedButton(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Resgatar crédito disponível',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      snapshot.data.vlrCashBack
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              color: Constantes.LARANJA,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: Constantes.customColorOrange)),
                              onPressed: () async {
                                setState(() {
                                  idVendedor =
                                      snapshot.data.vendedorDTO.idVendedor;
                                  idCliente = userId;
                                });
                                await httpService.resgatarCredito(
                                    context, idCliente, idVendedor);
                              })
                          : RaisedButton(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Crédito Acumulado',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      snapshot.data.vlrCashBack
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              color: Constantes.customColorCinza,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Constantes.customColorCinza)),
                              onPressed: () {}),
                    ],
                  )
                ],
              )
            ]);
          } else {
            return Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text("Aguarde..."),
              ],
            ));
          }
        },
      ),
    );
  }
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}
