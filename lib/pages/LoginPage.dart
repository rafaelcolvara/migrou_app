import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/services.dart';
import 'package:migrou_app/controller/controller.dart';
import 'package:migrou_app/controller/ctrl.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Controller();
  final ctrl = Ctrl();

  _optionSwith({String labelText, onChanged, bool valor}) {
    return SwitchListTile(
        value: valor,
        onChanged: onChanged,
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        activeColor: Color.fromRGBO(235, 134, 52, 1),
        title: new Text(
          labelText,
          style: new TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(235, 134, 52, 1)),
        ));
  }

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
      color: Color.fromRGBO(62, 64, 149, 1),
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

  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print('erro ao autenticar:' + e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          return ListView(
              padding: EdgeInsets.only(top: 100, left: 20, right: 20),
              children: <Widget>[
                SizedBox(
                  height: 130.0,
                  child: Image.asset(
                    "images/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                _text(
                    hint: "E-Mail",
                    obscureText: false,
                    type: TextInputType.emailAddress),
                _text(
                    hint: "Senha",
                    obscureText: true,
                    type: TextInputType.visiblePassword),
                Observer(builder: (_) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: new Center(
                      child: new Column(children: <Widget>[
                        _optionSwith(
                          labelText: controller.nomeLabelSwith(),
                          valor: controller.cliente.flgVendedor,
                          onChanged: controller.cliente.changeVendedor,
                        )
                      ]),
                    ),
                  );
                }),
                _loginButon(onPressed: _signInAnonymously),
                Padding(
                  padding: const EdgeInsets.all(12.0),
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
                  print("pediu cadastro");
                },
                child: Text(
                  "Cadastre-se!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(235, 134, 52, 1)),
                ),
              ),
            ],
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}
