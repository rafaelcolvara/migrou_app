import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/botos_home.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';

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
              MyCustomButton(text: "Dados Pessoias"),
              MyCustomButton(text: "Alterar Senha"),
              MyCustomButton(text: "Contato"),
              MyCustomButton(text: "Indique e Ganhe"),
            ],
          ),
        )
        // Center(
        //   child: Padding(
        //     padding: const EdgeInsets.all(30),
        //     child: ListView(
        //       children: [

        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
