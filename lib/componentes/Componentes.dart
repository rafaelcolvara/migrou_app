import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migrou_app/utils/definicoes.dart';

Widget logoMigrou(BuildContext context) {
  return SizedBox(
    height: 130.0,
    child: Image.asset(
      "images/logo.png",
      fit: BoxFit.contain,
    ),
  );
}

Widget slogan(BuildContext context) {
  return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text("Seu cartão de Fidelidade Virtual",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Tw Cen MT' , fontSize: 20.0).copyWith(
                color: Constantes.AZUL, fontWeight: FontWeight.bold)),
                    );
}