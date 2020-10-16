import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migrou_app/pages/DashCliente.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/pages/RootPage.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';

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
    final Color customColorBlue = Color.fromARGB(255, 62, 64, 149);
    final Color customColorOrange = Color.fromARGB(255, 245, 134, 52);

    return MaterialApp(
      theme: ThemeData(
          primaryColor: customColorBlue,
          accentColor: customColorOrange,
          textTheme: TextTheme(bodyText2: TextStyle(color: customColorBlue))),
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
