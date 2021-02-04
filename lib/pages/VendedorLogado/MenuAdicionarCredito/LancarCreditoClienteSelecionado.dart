import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:migrou_app/componentes/botos_home.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/utils/definicoes.dart';
import 'package:date_format/date_format.dart';

class LancaCredito extends StatefulWidget {
  final nome;
  final id;
  LancaCredito({
    @required this.id,
    @required this.nome,
  });

  @override
  _LancaCreditoState createState() => _LancaCreditoState();
}

class _LancaCreditoState extends State<LancaCredito> {
  var data = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]);
  bool busy = false;
  var valor = new MoneyMaskedTextController(
      decimalSeparator: ".", leftSymbol: 'R\$ ', precision: 2);
  @override
  Widget build(BuildContext context) {
    final PessoaWebClient httpServices = PessoaWebClient();

    double lancamento;
    return Scaffold(
      appBar: AppBar(title: Text("Cliente Selecionado")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Image.asset("images/no-image-default.png",
                fit: BoxFit.contain, height: 200, width: 200),
            SizedBox(height: 10),
            RichText(
                text: TextSpan(
                    text: widget.nome,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Constantes.customColorBlue))),
            Container(
              child: Text(
                "Tel.: (11) 12345-1234",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text("Valor gasto em $data",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
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
                        text: "Adicionar",
                      )),
          ],
        ),
      ),
    );
  }
}
