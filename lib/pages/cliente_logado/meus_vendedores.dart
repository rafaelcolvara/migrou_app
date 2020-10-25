import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/PessoaDTO.dart';

class VinculadosVendedores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PessoaWebClient httpServer = PessoaWebClient();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Meus Vendedores"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: httpServer.vendedoresVinculadosAoCliente(),
          builder: (_, snapshot) {
            // print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData)
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(child: Text('Nenhum')),
                    Center(
                      child: Text("VENDEDOR VINCULADO!"),
                    ),
                  ],
                );
              // print(snapshot.data);
              final List<PessoaDTO> meusClientes = snapshot.data;
              return ListView.builder(
                itemCount: meusClientes.length,
                itemBuilder: (BuildContext context, int index) {
                  PessoaDTO _p = meusClientes[index];
                  return Card(
                    child: new ListTile(
                      trailing:
                          Image.asset('images/logo.png', height: 30, width: 30),
                      title: Text(_p.nome),
                      subtitle: Text(_p.email),
                    ),
                  );
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
