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
          future: httpServices.localizarPorEmail(context, (code) {
            alertSearch(code);
          }),
          builder: (_, AsyncSnapshot<PessoaDTOnew> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData)
                return Center(child: Text("Verifique sua Conexão!"));
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: snapshot.data.urlFoto == null
                            ? Image.asset("images/no-image-default.png",
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.28,
                                fit: BoxFit.cover)
                            : Image.network(snapshot.data.urlFoto,
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.28,
                                fit: BoxFit.cover),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                          child: Text(snapshot.data.nome,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold))),
                      SizedBox(height: 3),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      InkWell(
                        onTap: () {
                          setState(() {
                            idVendedor = userId;
                            idCliente = snapshot.data.username;
                            httpServices.vincularCliente(
                                context, idCliente, idVendedor, (code) {
                              alertADD(code);
                            });
                          });
                        },
                        child: MyCustomButton(
                            color: Constantes.customColorBlue,
                            text: "Adicionar"),
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

  void alertADD(code) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Atenção!",
              style: TextStyle(color: Theme.of(context).primaryColor)),
          content: Text(code,
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                  height: 1.0,
                  fontWeight: FontWeight.w300)),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void alertSearch(code) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Atenção!",
              style: TextStyle(color: Theme.of(context).primaryColor)),
          content: Text(code,
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                  height: 1.0,
                  fontWeight: FontWeight.w300)),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
