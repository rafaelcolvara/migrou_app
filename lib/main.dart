import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migrou_app/pages/ClienteLogado.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/pages/RootPage.dart';
import 'package:migrou_app/pages/VendedorLogado.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';
import 'package:migrou_app/utils/definicoes.dart';

import 'pages/Cadastro.dart';


void main() {
  runApp(MyApp());  
} 

class MyApp extends StatefulWidget  {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  



  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
      title: 'Migrou App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    routes: {
      '/cadastroCliente': (context) => Cadastro(),
      '/login' : (context) => LoginPageAPI( auth: new Auth(),tipoPessoa: null,),   
      '/clienteLogado': (context) => ClienteLogado(),
      '/vendedorLogado': (context) => VendedorLogado(),
      '/RootPage': (context) => RootPage(auth: new Auth(),)   
    },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonColor: Constantes.AZUL
      ),
      home: RootPage(auth: new Auth()),
    );
  }
}



