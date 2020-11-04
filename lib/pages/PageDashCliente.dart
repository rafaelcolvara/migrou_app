import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:migrou_app/model/ClienteDashDTO.dart';
import 'package:migrou_app/pages/cliente_logado/cliente_resgatecredito.dart';
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
    var ddd = nomeTelefone.substring(0, 2);
    var teleP1 = nomeTelefone.substring(2, 7);
    var teleP2 = nomeTelefone.substring(7, 11);
    String profileIMG = nomeFotoStabelecimento;
    Uint8List bytes = base64.decode(profileIMG);
    String texto = """**Faltam** """ +
        widget.teste +
        """ compras para você ter __10%__ de desconto nas próximas compras. """;
    return Scaffold(
        body: ListView(
      children: <Widget>[
        SizedBox(
          height: 24.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            SizedBox(
              height: 24.0,
              width: 24.0,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 80,
                minHeight: 80,
                maxHeight: 120,
                maxWidth: 120,
              ),
              child: profileIMG == null || profileIMG == ""
                  ? Image.asset(
                      'images/no-image-default.png',
                      fit: BoxFit.cover,
                    )
                  : Image.memory(
                      bytes,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              width: 24,
            ),
            Column(
              children: <Widget>[
                Text(
                  nomeStabelecimento,
                  style: TextStyle(fontSize: 18.0, color: Colors.blueAccent),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Atividade: $nomeSegimento",
                  style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text('Tel: ($ddd) $teleP1-$teleP2')
              ],
            ),
          ],
        ),
        SizedBox(
          height: 24.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 12,
            ),
            SizedBox(
              width: 180,
              height: 180,
              child: new AnimatedCircularChart(
                key: _chartKey,
                size: Size(150.0, 150.0),
                holeRadius: 40.0,
                holeLabel: '8/10',
                initialChartData: <CircularStackEntry>[
                  new CircularStackEntry(
                    <CircularSegmentEntry>[
                      new CircularSegmentEntry(
                        85.5,
                        Constantes.LARANJA,
                        rankKey: 'completed',
                      ),
                      new CircularSegmentEntry(
                        14.5,
                        Colors.blueGrey[100],
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
                children: <Widget>[
                  Text('Valor gasto até: 15/01/2020'),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'R\$ 882,09',
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  MarkdownBody(data: texto),
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
            RaisedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Resgatar crédito disponível',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'R\$ 8,82',
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
                    side: BorderSide(color: Constantes.LARANJA)),
                onPressed: () {}),
          ],
        )
      ],
    ));
  }
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}
