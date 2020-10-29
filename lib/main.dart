import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migrou_app/pages/DashCliente.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/pages/RootPage.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';
import 'package:migrou_app/utils/definicoes.dart';

void main() {
  runApp(MyApp());
//desabilitar rotação de tela.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //MaterialColor teste = new MaterialColor(primary, swatch);

    return MaterialApp(
      theme: ThemeData(
          primaryColor: Constantes.customColorBlue,
          accentColor: Constantes.customColorOrange,
          textTheme: TextTheme(
              bodyText2: TextStyle(color: Constantes.customColorBlue))),
      home: RootPage(auth: new Auth()),
      title: 'Migrou App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPageAPI(auth: new Auth(), tipoPessoa: null),
        '/RootPage': (context) => RootPage(auth: new Auth()),
        DashCliente.routeName: (context) => DashCliente(),
      },
    );
  }
}
