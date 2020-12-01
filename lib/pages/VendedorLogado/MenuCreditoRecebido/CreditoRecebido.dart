import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/contaDTO.dart';

class CreditoRecebido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PessoaWebClient httpServices = PessoaWebClient();
    return Scaffold(
      appBar: AppBar(title: const Text("Crédito Recebido"), centerTitle: true),
      body: FutureBuilder(
          future: httpServices.meusClientesDASH(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData)
                return Center(child: Text("Dados indisponível"));
              final List<CashBackDTO> meusClientesResgate = snapshot.data;
              return ListView.builder(
                itemCount: meusClientesResgate.length,
                itemBuilder: (context, index) {
                  CashBackDTO _m = meusClientesResgate[index];
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
                              title: Text(_m.clienteDTO.pessoaDTO.nome),
                              subtitle: Text(_m.clienteDTO.pessoaDTO.email))
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
