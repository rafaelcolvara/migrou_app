import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/ArgumentosPaginaClienteDash.dart';
import 'package:migrou_app/componentes/Progress.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/ClienteVendedoresDTO.dart';
import 'package:migrou_app/model/VendedorDTO.dart';
import 'package:migrou_app/pages/DashCliente.dart';

class ListaVendedores extends StatelessWidget {
  const ListaVendedores({Key key, this.idCliente}) : super(key: key);

  final String idCliente;

  @override
  Widget build(BuildContext context) {
    final PessoaWebClient pessoaWebClient = new PessoaWebClient();

    return Container(
      child: Scaffold(
          appBar: new AppBar(
            title: Text("Escolha seu vendedor"),
          ),
          body: FutureBuilder<ClienteVendedoresDTO>(
              future: pessoaWebClient.buscaVendedoresPorIdCliente(
                  id: this.idCliente),
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
                    if (snapshot.data == null) break;
                    final ClienteVendedoresDTO clientesVendedores =
                        snapshot.data;
                    final List<VendedorDTO> vendedores =
                        clientesVendedores.vendedores;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final VendedorDTO vendedor = vendedores[index];
                        List<int> list =
                            vendedor.pessoaDTO.base64Foto.codeUnits;
                        Uint8List bytesImage = Base64Decoder()
                            .convert(vendedor.pessoaDTO.base64Foto);
                        Image naoexiste =
                            Image.asset('images/no-image-default.png');
                        return Card(
                          child: ListTile(
                            leading: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 80,
                                minHeight: 80,
                                maxHeight: 84,
                                maxWidth: 84,
                              ),
                              child: list.isNotEmpty
                                  ? Image.memory(bytesImage)
                                  : naoexiste,
                            ),
                            title: Text(vendedor.pessoaDTO.nome),
                            subtitle: Text(vendedor.nomeNegocio),
                            trailing: Text(vendedor.pessoaDTO.nrCelular),
                            onTap: () => {
                              Navigator.pushNamed(
                                  context, DashCliente.routeName,
                                  arguments: ArgumentosPaginaClienteDash(
                                      idVendedor: vendedor.idVendedor,
                                      idCliente: this.idCliente))
                            },
                          ),
                        );
                      },
                      itemCount: vendedores.length,
                    );

                    break;
                }
                return Text('Unknown Error');
              })),
    );
  }
}
