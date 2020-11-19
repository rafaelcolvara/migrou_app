import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:migrou_app/componentes/botos_home.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/contaDTO.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/utils/definicoes.dart';

class InfoClienteLocaliado extends StatefulWidget {
  @override
  _InfoClienteLocaliado createState() => _InfoClienteLocaliado();
}

class _InfoClienteLocaliado extends State<InfoClienteLocaliado> {
  @override
  Widget build(BuildContext context) {
    final PessoaWebClient httpServices = PessoaWebClient();
    return Scaffold(
        appBar: AppBar(title: Text("Adicionar Cliente")),
        body: FutureBuilder(
          future: httpServices.localizarPorEmail(context),
          builder: (_, AsyncSnapshot<PessoaDTOnew> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData)
                return Center(child: Text("Verifique sua Conexão!"));
              String profileIMG = snapshot.data.base64Foto;
              Uint8List bytes = base64.decode(profileIMG);
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      profileIMG == null || profileIMG == ""
                          ? Container(
                              width: 80,
                              height: 120,
                              child: Image.asset('images/no-image-default.png'),
                            )
                          : Container(
                              width: 80,
                              height: 120,
                              child: Image.memory(
                                bytes,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Text("Nome: ${snapshot.data.nome}"),
                      SizedBox(height: 10),
                      Text("Data Nascimento: ${snapshot.data.dataNascimento}"),
                      SizedBox(height: 10),
                      Text("E-mail: ${snapshot.data.email}"),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      InkWell(
                        onTap: () {
                          setState(() {
                            idVendedor = userId;
                            idCliente = snapshot.data.id;
                            httpServices.vincularCliente(
                                context, idCliente, idVendedor);
                          });
                        },
                        child: MyCustomButton(
                            color: Constantes.customColorBlue,
                            text: "Adicinar"),
                      )
                    ]),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Aguarde..."),
                  ],
                ),
              );
            }
          },
        ));
  }
}
