
import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/Arquivos.dart';

class Teste extends StatelessWidget {
  const Teste({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Arquivos a = new Arquivos();

  return FutureBuilder<String>(
    future: a.readContent(), // a previously-obtained Future<String> or null
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      List<Widget> children;

      if (snapshot.hasData) {
        children = <Widget>[
          Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Result: ${snapshot.data}'),
          )
        ];
      } else if (snapshot.hasError) {
        children = <Widget>[
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Error: ${snapshot.error}'),
          )
        ];
      } else {
        children = <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Awaiting result...'),
          )
        ];
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      );
    },
  );
}
}