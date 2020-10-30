import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/contaDTO.dart';
import 'package:migrou_app/utils/definicoes.dart';

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
              final List<PessoaDTOnew> meusClientes = snapshot.data;
              return ListView.builder(
                itemCount: meusClientes.length,
                itemBuilder: (BuildContext context, int index) {
                  PessoaDTOnew _p = meusClientes[index];
                  String profileIMG = _p.base64Foto;
                  Uint8List bytes = base64.decode(profileIMG);
                  return Card(
                    child: new ListTile(
                      trailing: _p.base64Foto == null || _p.base64Foto == ""
                          ? Image.asset('images/no-image-default.png',
                              height: 60, width: 60)
                          : Image.memory(
                              bytes,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                      title: Text(
                        _p.nomeNegocio,
                        style: TextStyle(
                            color: Constantes.customColorBlue,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          "${_p.segmentoComercial}\n${_p.email}\n${_p.nrCelular}"),
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
