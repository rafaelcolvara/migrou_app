import 'package:flutter/material.dart';


class VendedorLogado extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendedor - Logado'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Sair',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
              
            ),
            onPressed: () => null,
          ),
        ],
      ),
    );
  }
}