import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/Progress.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/model/ClienteDashDTO.dart';
import 'package:migrou_app/pages/PageDashCliente.dart';
import 'package:migrou_app/pages/cliente_logado/ClienteResgateCredito.dart';

class DashCliente extends StatelessWidget {
  static const routeName = '/dashCliente';

  DashCliente({String nomeIdVendedor});

  @override
  Widget build(BuildContext context) {
    final MovimentacaoWebClient movimentacaoWebClient =
        new MovimentacaoWebClient();

    return Container(
      child: Scaffold(
          appBar: AppBar(title: Text("Saldo Resgate"), centerTitle: true),
          body: FutureBuilder<ClienteDashDTO>(
              future: movimentacaoWebClient.buscaDashCliente(
                  idCliente: idCliente, idVendedor: nomeIdVendedor),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    break;
                  case ConnectionState.waiting:
                    return Progress();
                    break;
                  case ConnectionState.active:
                    break;
                  case ConnectionState.done:
                    return new TelaCliente(
                      clienteDashDTO: snapshot.data,
                      teste: '8',
                    );
                    break;
                }
                return Text('Unknown Error');
              })),
    );
  }
}
