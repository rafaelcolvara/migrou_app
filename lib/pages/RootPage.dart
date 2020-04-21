import 'package:flutter/material.dart';
import 'package:migrou_app/model/PessoaDTO.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'ClienteLogado.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  bool isLoggedIn = false;
  String _userId='';
  String _tipoPessoa;

  @override
  void initState() {
    super.initState();
    autoLogIn();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.id.toString();
        }
        authStatus =
            user?.id == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });

    if (authStatus==AuthStatus.LOGGED_IN){
      isLoggedIn=true;
    }
  }
  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', null);

    setState(() {
      _userId = '';
      isLoggedIn = false;
    });
  }

 Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.setString('id', this._userId);
    
    setState(() {      
      isLoggedIn = true;
    });
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('id');
    final String userNome = prefs.getString('nome');
    final String userEmail = prefs.getString('email');
    final String userEmailConfirmado = prefs.getString('flgConfirmacaoEmail');
    _tipoPessoa = prefs.getString('tipoPessoa');
    final PessoaDTO pessoaLogada = new PessoaDTO();
    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        pessoaLogada.id = int.tryParse(userId);
        pessoaLogada.nome = userNome;
        pessoaLogada.email = userEmail;
        pessoaLogada.flgEmailValido = userEmailConfirmado=='1';                
      });
      
      return;
    }
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.id.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginPageAPI( 
          auth: widget.auth,
          loginCallback: loginCallback,
          tipoPessoa: _tipoPessoa,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new ClienteLogado(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,          
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
