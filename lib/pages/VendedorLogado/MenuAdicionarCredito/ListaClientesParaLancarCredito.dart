import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/LancarCreditoDTO.dart';
import 'package:migrou_app/pages/VendedorLogado/MenuAdicionarCredito/LancarCreditoClienteSelecionado.dart';

class AdicinarCreditoClientes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PessoaWebClient httpServer = PessoaWebClient();
    return Scaffold(
      appBar: AppBar(title: Text("Selecione um Cliente"), centerTitle: true),
      body: FutureBuilder(
        future: httpServer.clientesVinculadosAoVendedor(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData)
              return Center(
                child: Text("Ops...\nSem dados."),
              );
            final List<Clientes> meusClientes = snapshot.data;
            return ListView.separated(
              itemCount: meusClientes.length,
              separatorBuilder: (_, int idex) => Divider(height: 1),
              itemBuilder: (_, int index) {
                Clientes _p = meusClientes[index];
                return ListTile(
                    onTap: () {
                      idCliente = _p.username;
                      Navigator.push(
                        _,
                        MaterialPageRoute(
                            builder: (_) =>
                                LancaCredito(nome: _p.nome, id: _p.nome)),
                      );
                    },
                    title: Center(child: Text(_p.nome)));
              },
            );
          } else {
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Center(child: CircularProgressIndicator()),
                  Text("Aguarde..."),
                ]));
          }
        },
      ),
    );
  }
}
