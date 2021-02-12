import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/VendedoresViculadorClientes.dart';
import 'package:migrou_app/pages/Cliente_Logado/ChatPage.dart/ClienteChatPage.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
// import 'package:migrou_app/pages/VendedorLogado/ChatPage.dart/VendedorChatPage.dart';

class VinculadosVendedores extends StatefulWidget {
  @override
  _VinculadosVendedoresState createState() => _VinculadosVendedoresState();
}

class _VinculadosVendedoresState extends State<VinculadosVendedores> {
  @override
  Widget build(BuildContext context) {
    final PessoaWebClient pessoaWebClient = PessoaWebClient();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Meus Vendedores"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: pessoaWebClient.vendedoresVinculadosAoCliente(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData)
                return AlertDialog(
                  title: new Text("Atenção!",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  content: Text(
                    "Nenhum vendedor vinculado",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.red,
                        height: 1.0,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: new Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              final List<VendVincCleinteDTO> meusClientes = snapshot.data;
              return ListView.builder(
                itemCount: meusClientes.length,
                itemBuilder: (BuildContext context, int index) {
                  VendVincCleinteDTO _p = meusClientes[index];
                  return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            idVendedor = _p.username;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClienteChatePage(
                                      idCliente: userId,
                                      userId: idVendedor,
                                    )),
                          );
                        },
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 180,
                                      child:
                                          _p.urlFoto == null || _p.urlFoto == ""
                                              ? Image.asset(
                                                  'images/no-image-default.png',
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  _p.urlFoto,
                                                  fit: BoxFit.cover,
                                                ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          _p.nomeNegocio,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(_p.nomeSegmento),
                                        Text(
                                          _p.nrCelular,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text("Fale com seu vendedor!")
                                      ],
                                    ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
                },
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
