import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/VendedoresViculadorClientes.dart';
import 'package:migrou_app/pages/DashCliente.dart';

String nomeStabelecimento;
String nomeSegimento;
String nomeTelefone;
String nomeIdVendedor;

class ResgateCredito extends StatefulWidget {
  @override
  _ResgateCreditoState createState() => _ResgateCreditoState();
}

class _ResgateCreditoState extends State<ResgateCredito> {
  @override
  Widget build(BuildContext context) {
    final PessoaWebClient pessoaWebClient = PessoaWebClient();
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecione um Vendedor"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: pessoaWebClient.vendedoresVinculadosAoCliente(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) return Center(child: Text("ops..."));
              final List<VendVincCleinteDTO> meusgetInfo = snapshot.data;
              return ListView.builder(
                itemCount: meusgetInfo.length,
                itemBuilder: (BuildContext context, int index) {
                  VendVincCleinteDTO i = meusgetInfo[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      i.nomeNegocio,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(i.nomeSegmento),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          child: Container(
                                              height: 30,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Text(
                                                    "Crédito/Resgate",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )),
                                          onTap: () {
                                            setState(() {
                                              nomeStabelecimento =
                                                  i.nomeNegocio;
                                              nomeSegimento = i.nomeSegmento;
                                              nomeTelefone = i.nrCelular;
                                              nomeIdVendedor = i.username;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DashCliente()),
                                            );
                                          }),
                                    )
                                  ],
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
