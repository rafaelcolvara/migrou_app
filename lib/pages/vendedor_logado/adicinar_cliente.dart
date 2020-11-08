import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/botos_home.dart';
import 'package:migrou_app/pages/vendedor_logado/adicionar_por_email.dart';
import 'package:migrou_app/pages/vendedor_logado/my_scan.dart';

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
                child: MyCustomButton(text: "Adicionar por e-mail"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPorEmail()),
                  );
                }),
            InkWell(
                child: MyCustomButton(text: "Adicionar por QRCODE"),
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
