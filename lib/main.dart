
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migrou_app/pages/LoginPage.dart';
import 'package:migrou_app/pages/MenuPrincipal.dart';
import 'package:migrou_app/utils/definicoes.dart';
import 'pages/Cadastro.dart';
import 'componentes/Arquivos.dart';

void main() {
  runApp(MyApp());  
} 

class MyApp extends StatelessWidget {

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Migrou App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    routes: {
      '/cadastroCliente': (context) => Cadastro(),
      '/login' : (context) => LoginPage( tipoPessoa: null,)      
    },

      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonColor: Constantes.AZUL
      ),
      home: MainPage(title: 'Migrou App'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  String tipoPessoaLocal;
  Arquivos arq = new Arquivos();


  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); 
    }
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user != null) {
            arq.readContent().then((String value) {
            setState(() {
                tipoPessoaLocal = value;
                });
            });
            if (tipoPessoaLocal==null || ( tipoPessoaLocal != 'VENDEDOR' && tipoPessoaLocal != 'CLIENTE' ) )  {
              arq.writeContent("");
              _signOut();
              Navigator.pop(context);
            } 
            return LoginPage(tipoPessoa: tipoPessoaLocal,);            
          }
          return MenuPrincipal();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}



