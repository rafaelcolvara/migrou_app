import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String _email;
  String _password;
  String _errorMessage;
  String _tipoPessoa ; 

  int theriGroupVakue=1;

  final Map<int, Widget> logoWidgets = const<int,Widget>{
    0:Text("Vendedor"),
    1:Text("Cliente")  };
 
  Future<Null> gravaTipoPessoa(String tipoPessoa) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.setString('tipoPessoa', tipoPessoa);

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
      if (_tipoPessoa !=null && _tipoPessoa.length>0) {
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
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password, _tipoPessoa);
          print('Logado: $userId');
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
            if (userId != null && userId.length > 0  && _isLoginForm) {
              widget.loginCallback();
            }
        } catch(e){
              print('resposta demorada');
        }
      } catch (e) {
        print('Error: $e');
        String mensagem;
        if (e is FormatException) {
          mensagem = "Erro de formatacao";
          switch (e.message) {
            case 'ERROR_INVALID_TIPO_PESSOA':
              mensagem = 'Pessoa não é Vendedora nem Cliente';
              break;
            case 'ERROR_USER_NOT_FOUND':
              mensagem = 'Usuário não existe';
              break;
            case 'ERROR_WRONG_PASSWORD':
              mensagem = 'Senha inválida';
              break;
            default:
              mensagem = 'Erro!';
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
    if(widget.tipoPessoa==null){
      _tipoPessoa = theriGroupVakue==0?"VENDEDOR":"CLIENTE";
    } else{
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
        appBar: new AppBar( 
          title: new Text('Entrar '),
        ),
        body: Stack(
          children: <Widget>[
            _showForm(),
            _showCircularProgress(),
          ],
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
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showLogo(),
              showEmailInput(),
              showPasswordInput(),
              showTipoPessoa(),
              showPrimaryButton(),
              showSecondaryButton(),
              showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0 ) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
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
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
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
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email não pode ser vazio' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Senha',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Senha não pode ser vazia' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }
  Widget showTipoPessoa(){
    return new Padding(
            padding: EdgeInsets.only(top: 24.0,bottom: 10.0),child: Row(
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),

                Expanded(
                  child: CupertinoSegmentedControl(
                    groupValue:theriGroupVakue,
                    onValueChanged: (changeFromGroupValue){
                      setState(() {
                        theriGroupVakue =changeFromGroupValue;
                        print('setou para $changeFromGroupValue');
                        gravaTipoPessoa(changeFromGroupValue==0?"VENDEDOR":"CLIENTE");
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
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text(_isLoginForm ? 'Entrar' : 'Criar Conta',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }
}
