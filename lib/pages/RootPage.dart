import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/Progress.dart';
import 'package:migrou_app/componentes/SharedPref.dart';
import 'package:migrou_app/model/PessoaDTO.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/pages/cliente_logado/ClienteLogado.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';
import 'vendedor_logado/VendedorLogado.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

String _userId = '';
String tipoPessoa = '.';

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  bool isLoggedIn = false;

  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    print("PASSO 1");
    super.initState();
    autoLogIn();
    print("PASSO 2");
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          if (user.id.toString() != "null") {
            print('PASSOU 8' + user.id.toString());
            _userId = user.id.toString();
          } else {
            _userId = '';
          }
        }
        authStatus =
            user.id == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });

    if (authStatus == AuthStatus.LOGGED_IN) {
      isLoggedIn = true;
    }
  }

  Future<Null> logout() async {
    sharedPref.remove('id');
    setState(() {
      _userId = '';
    });
  }

  Future<Null> loginUser() async {
    await sharedPref.save('id', _userId);
    print('PASSOU 9');
    setState(() {
      isLoggedIn = true;
    });
  }

  void autoLogIn() async {
    print("PASSO 3");
    final String userId = await sharedPref.read('id');
    final String userNome = await sharedPref.read('nome');
    final String userEmail = await sharedPref.read('email');
    final String userEmailConfirmado =
        await sharedPref.read('flgConfirmacaoEmail');
    tipoPessoa = await sharedPref.read('tipoPessoa');
    final PessoaDTO pessoaLogada = new PessoaDTO();
    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        pessoaLogada.id = userId;
        pessoaLogada.nome = userNome;
        pessoaLogada.email = userEmail;
        pessoaLogada.flgEmailValido = userEmailConfirmado == '1';
      });

      return;
    }
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        tipoPessoa = user.tipoPessoa.toString();
        _userId = user.id.toString();
        print("PASSO 4");
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      print("PASSO 5");
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
      tipoPessoa = "";
      isLoggedIn = false;
    });
  }

/*
  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    print('PASSOU 10');
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return Scaffold(body: Center(child: Progress()));
        break;
      case AuthStatus.NOT_LOGGED_IN:
        print("PASSO 7");
        return Scaffold(
          body: Center(
            child: new LoginPageAPI(
              auth: widget.auth,
              loginCallback: loginCallback,
              tipoPessoa: tipoPessoa,
            ),
          ),
        );
        break;
      case AuthStatus.LOGGED_IN:
        print("PASSO 6");
        //print("&&&&&&&&&&&&& ->> AUTOLOGIN COMO " + _tipoPessoa);
        if (_userId.length > 0 && _userId != null) {
          if (tipoPessoa == "CLIENTE") {
            return new ClienteLogado(
              userId: _userId,
              auth: widget.auth,
              logoutCallback: logoutCallback,
            );
          } else if (tipoPessoa == "VENDEDOR") {
            return new VendedorLogado(
              userId: _userId,
              auth: widget.auth,
              logoutCallback: logoutCallback,
            );
          } else {
            return Scaffold(
                body: Center(child: Text("Sem Referencia tipoPessoa")));
          }
        } else
          return Progress();
        break;
      default:
        return Progress();
    }
  }
}
