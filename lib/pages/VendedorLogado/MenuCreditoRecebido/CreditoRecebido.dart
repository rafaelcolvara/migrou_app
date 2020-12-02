import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/DataResgateDTO.dart';

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
                  return Card(
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
                          new ListTile(
                              title: Text(_m.nomeCliente),
                              subtitle: Text(_m.dataUltimoResgate)),
                          new Center(
                            child: Text(_m.vlrUltimoResgate.toStringAsFixed(2)),
                          )
                        ]))
                  ]));
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
