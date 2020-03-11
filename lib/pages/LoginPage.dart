import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migrou_app/componentes/Componentes.dart';
import 'package:migrou_app/controller/controller.dart';
import 'package:migrou_app/controller/ctrl.dart';
import 'package:migrou_app/pages/Cadastro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:migrou_app/utils/definicoes.dart';

class LoginPage extends StatefulWidget {
  final String tipoPessoa;

  LoginPage({Key key, @required this.tipoPessoa}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Controller();
  final ctrl = Ctrl();

  _text({String hint, bool obscureText, type}) {
    return TextField(
        obscureText: obscureText,
        keyboardType: type,
        decoration: InputDecoration(
            border: UnderlineInputBorder(
                borderSide: (BorderSide(
              width: 2.0,
              color: Colors.blueGrey,
              style: BorderStyle.solid,
            ))),
            hintText: hint));
  }

  _loginButon({onPressed}) {
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Constantes.AZUL,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: onPressed,
        child: Text("Entrar",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          return ListView(
              padding:
                  EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 10),
              children: <Widget>[
                Center(
                  child: logoMigrou(context),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _text(
                        hint: "E-Mail",
                        obscureText: false,
                        type: TextInputType.emailAddress)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _text(
                      hint: "Senha",
                      obscureText: true,
                      type: TextInputType.visiblePassword),
                ),
                SizedBox(height  : 24,),
                _loginButon(onPressed: _signInAnonymously),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Esqueceu a senha?"),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            print("pediu nova senha");
                          },
                          child: new Container(
                            color: Colors.white,
                            child: new Column(children: [
                              new Text(
                                "Clique aqui",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ))
                    ],
                  ),
                ),
              ]);
        }),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _showNewUserForm(context);
                },
                child: Text(
                  "Cadastre-se!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Constantes.LARANJA),
                ),
              ),
            ],
          ),
        ),
        color: Colors.white,
      ),
    );
  }

  void _showNewUserForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Cadastro(),
      ),
    );
  }

  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: null, password: null);
    } catch (e) {
      print('erro ao autenticar:' + e);
    }
  }
}
