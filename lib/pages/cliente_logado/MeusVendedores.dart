import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/VendedoresViculadorClientes.dart';
import 'package:migrou_app/pages/Cliente_Logado/ChatPage.dart/ClienteChatPage.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
// import 'package:migrou_app/pages/VendedorLogado/ChatPage.dart/VendedorChatPage.dart';
import 'package:migrou_app/utils/definicoes.dart';

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
              print(snapshot.data);
              final List<VendVincCleinteDTO> meusClientes = snapshot.data;
              return ListView.builder(
                itemCount: meusClientes.length,
                itemBuilder: (BuildContext context, int index) {
                  VendVincCleinteDTO _p = meusClientes[index];
                  return Padding(
                      padding: const EdgeInsets.all(10.0),
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
                                    width: 80,
                                    height: 120,
                                    child: Image.asset('images/pati.png'),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new ListTile(
                                        title: Text(
                                          _p.nome,
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(_p.nome),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.alternate_email,
                                              color:
                                                  Constantes.customColorOrange),
                                          SizedBox(width: 2),
                                          Text(_p.username),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.phone_android,
                                            color: Constantes.customColorOrange,
                                          ),
                                          SizedBox(width: 2),
                                          IconButton(
                                              icon: Icon(
                                                Icons.chat,
                                                color: Constantes
                                                    .customColorOrange,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  idVendedor = _p.username;
                                                });
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ClienteChatePage(
                                                            idCliente: userId,
                                                            userId: idVendedor,
                                                          )),
                                                );
                                              })
                                        ],
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            )
                          ],
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
