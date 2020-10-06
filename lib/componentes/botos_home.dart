import 'package:flutter/material.dart';
import 'package:migrou_app/utils/definicoes.dart';

// ignore: must_be_immutable
class MyCustomButton extends StatelessWidget {
  var text = "";

  MyCustomButton({
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 10.0,
              offset: Offset(0.0, 0.0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [
              Color(Constantes.AZUL.value),
              Color(Constantes.AZUL.value),
            ],
          )),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
