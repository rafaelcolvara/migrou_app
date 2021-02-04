import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/DataResgateDTO.dart';
import 'package:migrou_app/utils/definicoes.dart';

class CreditoRecebido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PessoaWebClient httpServices = PessoaWebClient();
    return Scaffold(
      appBar: AppBar(title: const Text("Crédito Recebido"), centerTitle: true),
      body: FutureBuilder(
          future: httpServices.meusClientesCreditoRecebido(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData) {
                print(snapshot.error);
                return Center(child: Text("Dados indisponível"));
              }
              final List<DataResgates> meusClientesResgate = snapshot.data;
              return ListView.builder(
                itemCount: meusClientesResgate.length,
                itemBuilder: (context, index) {
                  DataResgates _m = meusClientesResgate[index];
                  final String ano = _m.dataUltimoResgate.substring(0, 4);
                  final String mes = _m.dataUltimoResgate.substring(5, 7);
                  final String dia = _m.dataUltimoResgate.substring(8, 10);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Row(children: [
                      Container(
                          child: Center(
                        child: Image.asset("images/no-image-default.png",
                            fit: BoxFit.cover, height: 150, width: 130),
                      )),
                      Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                            Center(
                                child: new RichText(
                              text: TextSpan(
                                  text: "${_m.nomeCliente}\n",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Constantes.customColorBlue),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "Resgatou em $dia/$mes/$ano",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Constantes.customColorOrange))
                                  ]),
                            )),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: new Center(
                                  child: Text(
                                      "R\$ " +
                                          _m.vlrUltimoResgate
                                              .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Constantes.customColorBlue))),
                            )
                          ]))
                    ])),
                  );
                },
              );
            } else {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Center(child: Text("guarde..."))
                  ]);
            }
          }),
    );
  }
}
