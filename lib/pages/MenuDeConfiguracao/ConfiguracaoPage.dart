import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/botos_home.dart';
import 'package:migrou_app/pages/MenuDeConfiguracao/DadosPessoaisPage.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';
import 'package:migrou_app/utils/definicoes.dart';

class MenuSettings extends StatelessWidget {
  MenuSettings({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  signOut() async {
    try {
      await auth.signOut();
      logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  child: MyCustomButton(
                      color: Constantes.customColorBlue,
                      text: "Dados Pessoias"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DadosPessoais()),
                    );
                  }),
              MyCustomButton(
                  color: Constantes.customColorBlue, text: "Alterar Senha"),
              MyCustomButton(
                  color: Constantes.customColorBlue, text: "Contato"),
              MyCustomButton(
                  color: Constantes.customColorBlue, text: "Indique e Ganhe"),
            ],
          ),
        ));
  }
}
