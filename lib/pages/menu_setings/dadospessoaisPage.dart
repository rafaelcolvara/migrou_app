import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/infoDTO.dart';

class DadosPessoais extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PessoaWebClient httpServer = PessoaWebClient();
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: httpServer.infoCliente(),
          builder: (_, AsyncSnapshot<InforDTO> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot.error);
              if (!snapshot.hasData)
                return Center(child: Text("Ops...\nVerifique sua conexão!"));
//decodificação da imagem em base64
              String profileIMG = snapshot.data.base64Foto;
              Uint8List bytes = base64.decode(profileIMG);
//conversão do telelefone para formato (ddd)12345-6789
              var ddd = snapshot.data.nrCelular.substring(0, 2);
              var teleP1 = snapshot.data.nrCelular.substring(2, 7);
              var teleP2 = snapshot.data.nrCelular.substring(7, 11);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    profileIMG == null || profileIMG == ""
                        ? Stack(
                            children: [
                              Container(
                                width: 80,
                                height: 120,
                                child:
                                    Image.asset('images/no-image-default.png'),
                              ),
                              Positioned(
                                  bottom: 0, right: 0, child: Icon(Icons.edit))
                            ],
                          )
                        : Stack(
                            children: [
                              Container(
                                width: 80,
                                height: 120,
                                child: Image.memory(
                                  bytes,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  bottom: 0, right: 0, child: Icon(Icons.edit))
                            ],
                          ),
                    SizedBox(height: 10),
                    Text("Nome: ${snapshot.data.nome}"),
                    SizedBox(height: 10),
                    Text("Data Nascimento: ${snapshot.data.dataNascimento}"),
                    SizedBox(height: 10),
                    Text("Tel: ($ddd) $teleP1-$teleP2"),
                    SizedBox(height: 10),
                    Text("E-mail: ${snapshot.data.email}"),
                    SizedBox(width: 10),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
