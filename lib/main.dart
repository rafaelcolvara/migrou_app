import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migrou_app/pages/DashCliente.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/pages/RootPage.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';




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
    //MaterialColor teste = new MaterialColor(primary, swatch);

    return MaterialApp(
      title: 'Migrou App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    routes: {
      '/login' : (context) => LoginPageAPI( auth: new Auth(),tipoPessoa: null,),   
      '/RootPage': (context) => RootPage(auth: new Auth(),),
      DashCliente.routeName : (context) => DashCliente(),
    },
      theme: ThemeData(
        primarySwatch: Colors.blue,        
      ),
      home: RootPage(auth: new Auth()),
    );
  }
}



