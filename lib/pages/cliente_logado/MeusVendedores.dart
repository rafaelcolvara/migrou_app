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
                  var ddd = _p.nrCelular.substring(0, 2);
                  var teleP1 = _p.nrCelular.substring(2, 7);
                  var teleP2 = _p.nrCelular.substring(7, 11);
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
                                      child: Image.asset(
                                        'images/pati.png',
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
                                          "($ddd) $teleP1-$teleP2",
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
