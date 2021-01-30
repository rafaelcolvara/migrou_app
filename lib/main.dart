import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/pages/DashCliente.dart';
import 'package:migrou_app/pages/RootPage.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';
import 'package:migrou_app/utils/definicoes.dart';
import 'package:provider/provider.dart';

import 'CriarContaPage.dart';

void main() async {
// //nova regra para inicializar acesso ao firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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

    return ChangeNotifierProvider(
        create: (_) => PessoaWebClient(),
        child: MaterialApp(
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
            '/RootPage': (context) => RootPage(auth: new Auth()),
            DashCliente.routeName: (context) => DashCliente(),
            '/CriarConta': (context) => CriarContaPage(),
          },
        ));
  }
}
