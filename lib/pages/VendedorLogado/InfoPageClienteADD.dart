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
              final String ddd = snapshot.data.nrCelular.substring(0, 2);
              final String teleP1 = snapshot.data.nrCelular.substring(2, 5);
              final String teleP2 = snapshot.data.nrCelular.substring(5, 11);
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      profileIMG == null || profileIMG == ""
                          ? Container(
                              child: Image.asset('images/pati.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.28,
                                  fit: BoxFit.cover),
                            )
                          : Container(
                              child: Image.memory(
                                bytes,
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.28,
                                fit: BoxFit.cover,
                              ),
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                          child: Text(snapshot.data.nome,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold))),
                      SizedBox(height: 3),
                      Container(
                          child: Text(
                              "Data Nascimento: ${snapshot.data.dataNascimento}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300))),
                      SizedBox(height: 3),
                      Container(
                          child: Text("E-mail: ${snapshot.data.email}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300))),
                      SizedBox(height: 3),
                      Container(
                          child: Text("Tel.: ($ddd) $teleP1-$teleP2",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300))),
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
