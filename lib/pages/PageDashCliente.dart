import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


class TelaCliente extends StatelessWidget {
  const TelaCliente({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String texto = """**Faltam** """ + '23' +""" compras para você ter __10%__ de desconto nas próximas compras. """;
    return Container(
        child: ListView(
      children: <Widget>[
        SizedBox(height: 24.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            SizedBox(height: 24.0,width: 24.0,),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 80,
                minHeight: 80,
                maxHeight: 120,
                maxWidth: 120,
              ),
              child: Image.asset('images/no-image-default.png'),
            ),
            SizedBox(width: 24,),
            Column(
              children: <Widget>[
                Text('Patricia Petroli', style: TextStyle(fontSize: 18.0, color: Colors.blueAccent),),
                SizedBox(height: 8.0,),
                Text('Consultora Mary Kay', style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),),
                SizedBox(height: 4.0,),
                Text('Tel: 12-995623551')
              ],
            ),
            
          ],
        ),
        SizedBox(height: 36.0,),
        Row(
          children: <Widget>[
            SizedBox(width: 12,),
            Placeholder(
              fallbackHeight: 150, 
              fallbackWidth: 150,),
            SizedBox(width: 12,),
            Expanded(
                 child: Column(
                  children: <Widget>[
                    Text('Valor gasto até: 15/01/2020'),
                    SizedBox(height: 8,),
                    Text('R\$ 882,09', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),),
                    SizedBox(height: 8,),
                    MarkdownBody(data: texto)                     
                ],
              ),
            ),
            
          ],
        ),
        SizedBox(height: 20,),
        RaisedButton(
          child: Text('asdas'),
        
          onPressed: null)
      ],
    ));
  }
}
