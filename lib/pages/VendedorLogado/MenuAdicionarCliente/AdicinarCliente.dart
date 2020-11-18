import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/botos_home.dart';
import 'package:migrou_app/pages/VendedorLogado/MenuAdicionarCliente/AdicionarPorQRCODE.dart';
import 'package:migrou_app/pages/vendedor_logado/menu_AdicionarCliente/adicionar_por_email.dart';
import 'package:migrou_app/utils/definicoes.dart';

class AddClienteMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adicinar Cliente"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
                child: MyCustomButton(
                    color: Constantes.customColorBlue, text: "Por e-mail"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPorEmail()),
                  );
                }),
            InkWell(
                child: MyCustomButton(
                    color: Constantes.customColorBlue, text: "Por QRCODE"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyScanCode()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
