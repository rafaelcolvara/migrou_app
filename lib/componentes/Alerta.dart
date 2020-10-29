// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class AlertaDialogo extends StatefulWidget {
//   final bool flgOk;
//   final String textoMensagem;

//   const AlertaDialogo({this.flgOk, this.textoMensagem, Key key})
//       : super(key: key);

//   @override
//   _AlertaDialogoState createState() => _AlertaDialogoState();
// }

// class _AlertaDialogoState extends State<AlertaDialogo> {
//   @override
//   Widget build(BuildContext contextDialog) {
//     return AlertDialog(
//       title: Text("Migrou"),
//       content: Text(widget.textoMensagem),
//       actions: <Widget>[
//         FlatButton(
//             child: Text("OK"),
//             onPressed: () {
//               if (widget.flgOk) {
//                 print('apertou ok');
//                 Navigator.pushAndRemoveUntil(
//                   contextDialog,
//                   CupertinoPageRoute(
//                       builder: (context) => LoginPageAPI(tipoPessoa: 'CLIENTE')),
//                       (r) => false
//                 );
//               } else {
//                 Navigator.pop(contextDialog );
//               }
//             })
//       ],
//     );
//   }
// }
