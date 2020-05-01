
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/Progress.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/ClienteVendedoresDTO.dart';
import 'package:migrou_app/model/VendedorDTO.dart';

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
              future: pessoaWebClient.buscaVendedoresPorIdCliente(id: this.idCliente),

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
                    final ClienteVendedoresDTO clientesVendedores =  snapshot.data;
                    final List<VendedorDTO> vendedores = clientesVendedores.vendedores;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final VendedorDTO vendedor = vendedores[index];
                        List<int> list = vendedor.pessoaDTO.base64Foto.codeUnits;
                        Uint8List bytesImage = Base64Decoder().convert(vendedor.pessoaDTO.base64Foto);

                        return Card(
                          child: ListTile(
                            leading: SizedBox(
                              width: 90,
                              height: 120,
                              child: list.isNotEmpty?Image.memory(bytesImage):Image.asset('/images/no-image-default.png'),
                            ) ,
                            title: Text(vendedor.pessoaDTO.nome),
                            subtitle: Text(vendedor.nomeNegocio),
                            trailing: Text(vendedor.pessoaDTO.nrCelular),                            
                            onTap: () => {
                              print('bateu aqui ' + vendedor.pessoaDTO.nome)
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
