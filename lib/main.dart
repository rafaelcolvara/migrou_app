import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migrou_app/utils/definicoes.dart';
import 'pages/Cadastro.dart';
import 'pages/LoginPage.dart';


void main() {
  runApp(MyApp());
 
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Migrou App',
      debugShowCheckedModeBanner: false,      
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonColor: Constantes.AZUL
      ),
      home: SignInPage()//LandingPage(title: 'Migrou App'),
    );
  }
}

class LandingPage extends StatefulWidget {
  LandingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user != null) {
           print('user existe, abre opções para esclher quem ele é');
            return LoginPage();            
          }
          return SignInPage();
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

class SignInPage extends StatelessWidget {

  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print('erro ao autenticar:' + e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final clienteBotton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Constantes.LARANJA,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: _signInAnonymously ,
        child: Text("Sou Cliente",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0).copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final vendedorBotton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Constantes.CINZA,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
        onPressed: _signInAnonymously,
        child: Text("Sou Vendedor(a)",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0).copyWith(
                color: Constantes.LARANJA, fontWeight: FontWeight.bold)),
      ),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Color.fromRGBO(62, 64, 149, 1),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(context, CupertinoPageRoute(builder: (context) => Cadastro()));
        },
        child: Text("Criar Conta",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0).copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        "images/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Seu cartão de fidelidade Virtual",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 16.0).copyWith(
                color: Constantes.AZUL, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 40.0),
                    clienteBotton,
                    SizedBox(height: 25.0),
                    vendedorBotton,
                    SizedBox(height: 25.0),
                    loginButon,
                    SizedBox(height: 25.0),

                  ],
                ),
              ),
            )
          ],
        ),
      )
      ,
    );


  }
}

