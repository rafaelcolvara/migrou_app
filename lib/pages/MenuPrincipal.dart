import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/Arquivos.dart';
import 'package:migrou_app/pages/RootPage.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';
import 'package:migrou_app/utils/definicoes.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Arquivos arqu = new Arquivos();
    print('buildou novamente');
    final clienteButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Constantes.LARANJA,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          arqu.writeContent('CLIENTE');
          Navigator.pushReplacementNamed(context, '/RootPage');         
        },
        child: Text("Sou Cliente",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final vendedorButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Constantes.CINZA,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
        onPressed: () {
          arqu.writeContent('VENDEDOR');
          Navigator.popAndPushNamed(context, '/RootPage');
        },
        child: Text("Sou Vendedor(a)",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0).copyWith(
                color: Constantes.LARANJA, fontWeight: FontWeight.bold)),
      ),
    );

    return FutureBuilder<String>(
        future: arqu.readContent(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          print('está no future...' + snapshot.connectionState.toString() );
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else if (snapshot?.data == null || snapshot?.data=="") {
              print('caralho:' + snapshot?.data.toString());
              return Scaffold(
                body: Center(
                  child: new ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20.0),
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(36.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 155.0,
                                child: Image.asset("images/logo.png",
                                    fit: BoxFit.contain),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Seu cartão de fidelidade Virtual",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 16.0)
                                      .copyWith(
                                          color: Constantes.AZUL,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 40.0),
                              clienteButton,
                              SizedBox(height: 25.0),
                              vendedorButton,
                              SizedBox(height: 25.0),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            else {
              print('vai direcionar a rota');
              return RootPage( auth: new Auth());
            }
          }
        });
  }


}
