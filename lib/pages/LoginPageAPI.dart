import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/SharedPref.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';
import 'package:migrou_app/utils/definicoes.dart';

String userId = "";

class LoginPageAPI extends StatefulWidget {
  LoginPageAPI({this.auth, this.loginCallback, @required this.tipoPessoa});

  final BaseAuth auth;
  final VoidCallback loginCallback;
  final String tipoPessoa;

  @override
  State<StatefulWidget> createState() => new _LoginPageAPIState();
}

class _LoginPageAPIState extends State<LoginPageAPI> {
  final _formKey = new GlobalKey<FormState>();
  SharedPref sharedPref = SharedPref();

  String _email;
  String _password;
  String _errorMessage;
  String _tipoPessoa;

  int theriGroupVakue;

  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text("Vendedor"),
    1: Text("Cliente")
  };

  gravaTipoPessoa(String tipoPessoa) async {
    await sharedPref.save('tipoPessoa', tipoPessoa);
    setState(() {
      _tipoPessoa = tipoPessoa;
    });
  }

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      if (_tipoPessoa != null && _tipoPessoa.length > 0) {
        form.save();
        return true;
      }
      return false;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password, _tipoPessoa);
          print('Logado: $userId');
          SharedPref().save('tipoPessoa', _tipoPessoa);
        } else {
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();

          _showVerifyEmailSentDialog();
          print('Registrado: $userId');
        }
        setState(() {
          _isLoading = false;
        });
        try {
          if (userId != null && userId.length > 0 && _isLoginForm) {
            widget.loginCallback();
          }
        } catch (e) {
          print('resposta demorada');
        }
      } catch (e) {
        print('Error: $e');
        String mensagem;
        if (e is FormatException) {
          mensagem = "Erro de formatacao";
          switch (e.message) {
            case 'AUTHENTICATION_ERROR':
              mensagem = 'Usuário ou senha inválida';
              break;
            default:
              mensagem = "Não foi possível realizar login";
              break;
          }
        }

        setState(() {
          _isLoading = false;
          _errorMessage = mensagem;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    if (widget.tipoPessoa == null) {
      _tipoPessoa = theriGroupVakue = null;
    } else {
      _tipoPessoa = widget.tipoPessoa;
    }

    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height / 0.6,
      child: Stack(
        children: <Widget>[
          _showForm(),
          _showCircularProgress(),
        ],
      ),
    ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void alertipoPessoa() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Atenção",
                style: TextStyle(color: Theme.of(context).primaryColor)),
            content: Text(
              "Escolha uma das opções:\nVENDEDOR ou CLIENTE",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                  height: 1.0,
                  fontWeight: FontWeight.w300),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  toggleFormMode();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verifique sua conta"),
          content:
              new Text("Um link para verificação foi enviada no seu email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                toggleFormMode();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Stack(
          children: [
            new Form(
              key: _formKey,
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.13),
                  showLogo(),
                  showEmailInput(),
                  showPasswordInput(),
                  showTipoPessoa(),
                  showPrimaryButton(),
                  showSecondaryButton(),
                ],
              ),
            ),
            Container(child: showErrorMessage())
          ],
        ));
  }

  Widget showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return new AlertDialog(
        actions: [
          FlatButton(
              onPressed: () => Navigator.of(context).pushNamed("/"),
              child: Text("Fechar"))
        ],
        clipBehavior: Clip.none,
        title: Text("Atenção",
            style: TextStyle(color: Theme.of(context).primaryColor)),
        content: Text(
          _errorMessage,
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.red,
              height: 1.0,
              fontWeight: FontWeight.w300),
        ),
      );
      // Text(
      //   _errorMessage,
      //   style: TextStyle(
      //       fontSize: 13.0,
      //       color: Colors.red,
      //       height: 1.0,
      //       fontWeight: FontWeight.w300),
      // );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset("images/logo.png", fit: BoxFit.contain),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            prefixIcon: Icon(
              Icons.alternate_email,
              color: Theme.of(context).accentColor,
            ),
            labelStyle:
                TextStyle(color: Constantes.customColorCinza, fontSize: 18),
            alignLabelWithHint: true,
            labelText: 'Email'),
        validator: (value) => value == "Email " || value.isEmpty
            ? 'Email não pode ser vazio'
            : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            prefixIcon: Icon(
              Icons.vpn_key,
              color: Theme.of(context).accentColor,
            ),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
            alignLabelWithHint: true,
            labelText: 'Senha '),
        validator: (value) => value.isEmpty ? 'Senha não pode ser vazia' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showTipoPessoa() {
    return new Padding(
      padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: CupertinoSegmentedControl(
              selectedColor: Theme.of(context).primaryColor,
              groupValue: theriGroupVakue,
              onValueChanged: (changeFromGroupValue) {
                setState(() {
                  theriGroupVakue = changeFromGroupValue;
                  print('setou para $changeFromGroupValue');
                  gravaTipoPessoa(
                      changeFromGroupValue == 0 ? "VENDEDOR" : "CLIENTE");
                });
              },
              children: logoWidgets,
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
    );
  }

  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(_isLoginForm ? 'Criar conta' : 'Já tem conta? Entre!',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: toggleFormMode);
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: theriGroupVakue == null
              ? new RaisedButton(
                  elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Constantes.customColorCinza,
                  child: new Text(_isLoginForm ? 'Entrar' : 'Criar Conta',
                      style:
                          new TextStyle(fontSize: 20.0, color: Colors.white)),
                  onPressed: alertipoPessoa,
                )
              : new RaisedButton(
                  elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Theme.of(context).primaryColor,
                  child: new Text(_isLoginForm ? 'Entrar' : 'Criar Conta',
                      style:
                          new TextStyle(fontSize: 20.0, color: Colors.white)),
                  onPressed: validateAndSubmit,
                ),
        ));
  }
}
