
import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/ArgumentosPaginaClienteDash.dart';
import 'package:migrou_app/componentes/Progress.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/model/ClienteDashDTO.dart';
import 'package:migrou_app/pages/PageDashCliente.dart';

class DashCliente extends StatelessWidget {
  

  static const routeName = '/dashCliente';

  @override
  Widget build(BuildContext context) {
    
    final ArgumentosPaginaClienteDash args = ModalRoute.of(context).settings.arguments;
    
    final MovimentacaoWebClient movimentacaoWebClient = new MovimentacaoWebClient();    

    return Container(
      child: Scaffold(
          appBar: new AppBar(
            title: Text("Seu Saldo"),
          ),
          body: FutureBuilder<ClienteDashDTO>(
              future: movimentacaoWebClient.buscaDashCliente(idCliente: args.idCliente, idVendedor: args.idVendedor),

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
                   
                    return new TelaCliente();

                    break;
                }
                return Text('Unknown Error');
              })),
    );
  }

}
