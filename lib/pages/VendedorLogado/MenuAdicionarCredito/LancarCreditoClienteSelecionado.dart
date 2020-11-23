import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:migrou_app/componentes/botos_home.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/utils/definicoes.dart';

class LancaCredito extends StatefulWidget {
  final nome;
  final telefone;
  final id;
  final foto;
  LancaCredito(
      {@required this.foto,
      @required this.id,
      @required this.nome,
      @required this.telefone});

  @override
  _LancaCreditoState createState() => _LancaCreditoState();
}

class _LancaCreditoState extends State<LancaCredito> {
  bool busy = false;
  @override
  Widget build(BuildContext context) {
    final PessoaWebClient httpServices = PessoaWebClient();
    var valor = new MoneyMaskedTextController(
        decimalSeparator: ".", leftSymbol: 'R\$ ', precision: 2);
    var ddd = widget.telefone.substring(0, 2);
    var teleP1 = widget.telefone.substring(2, 7);
    var teleP2 = widget.telefone.substring(7, 11);
    String profileIMG = widget.foto;
    Uint8List bytes = base64.decode(profileIMG);
    double lancamento;
    return Scaffold(
      appBar: AppBar(title: Text("Cliente Selecionado")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            widget.foto == null || widget.foto == ""
                ? Image.asset("images/no-image-default.png",
                    fit: BoxFit.cover, height: 100, width: 80)
                : Image.memory(bytes,
                    fit: BoxFit.cover, height: 100, width: 80),
            SizedBox(height: 10),
            Text(widget.nome, style: TextStyle(fontSize: 20)),
            Text(
              "Tel.: ($ddd) $teleP1-$teleP2",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                  left: 60, right: 60, top: 10, bottom: 10),
              child: new TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style:
                    TextStyle(fontSize: 24, color: Constantes.customColorBlue),
                maxLines: 1,
                controller: valor,
              ),
            ),
            SizedBox(height: 15),
            InkWell(
                onTap: () async {
                  setState(() {
                    lancamento = valor.numberValue;
                  });
                  await httpServices.lancarCreditoAPI(
                      context, idCliente, userId, lancamento);
                },
                child: busy == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : MyCustomButton(
                        color: Constantes.customColorOrange,
                        text: "ADICIONAR CRÉDITO")),
          ],
        ),
      ),
    );
  }
}
