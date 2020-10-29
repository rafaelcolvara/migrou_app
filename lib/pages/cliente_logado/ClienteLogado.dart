import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/Arquivos.dart';
import 'package:migrou_app/componentes/botos_home.dart';
import 'package:migrou_app/pages/cliente_logado/cliente_resgatecredito.dart';
import 'package:migrou_app/pages/cliente_logado/meus_vendedores.dart';
import 'package:migrou_app/pages/cliente_logado/widget_cliente_logado.dart';
import 'package:migrou_app/pages/menu_setings/settings_page.dart';
import 'package:migrou_app/pages/cliente_logado/my_qrcode.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';
import 'package:migrou_app/utils/definicoes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClienteLogado extends StatefulWidget {
  ClienteLogado({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _ClienteLogadoState();
}

class _ClienteLogadoState extends State<ClienteLogado>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  AnimationController _controller;
  double _scale;
  Arquivos arq = new Arquivos();

  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    _checkEmailVerification();
  }

  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    }
  }

  void _resentVerifyEmail() {
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verifique seu e-mail"),
          content: new Text(
              "Por favor, valide sua conta clicando no link enviado no seu email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Reenvie link"),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verifique sua conta de e-mail"),
          content: new Text(
              "Um link de verificação foi enviado. Cheque seu e-mail."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      await arq.writeContent("");
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  addNewTodo(String todoItem) {
    if (todoItem.length > 0) {}
  }

  showAddTodoDialog(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    Map prefsMap;
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }
    print(prefsMap);

    _textEditingController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(
                    child: new TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Add new todo',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    addNewTodo(_textEditingController.text.toString());
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return new Scaffold(
        appBar: new AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuSettings()),
                );
              },
              icon: Icon(Icons.menu)),
          centerTitle: true,
          title: new Text('Cliente'),
          actions: <Widget>[
            new FlatButton(
                child: new Text('Sair',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: signOut)
          ],
        ),
        body: Center(
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(1.0),
            children: <Widget>[
              Center(
                  child: Text(
                'Escolha uma das opções abaixo',
                style: TextStyle(
                    color: Constantes.customColorCinza, fontSize: 20.0),
              )),
              SizedBox(
                height: 20.0,
              ),
              DetectoHome(
                filho: MyCustomButton(text: "Meus vendedores"),
                scale: _scale,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VinculadosVendedores()),
                  );
                },
                ontapDown: _onTapDown,
                ontapUp: _onTapUp,
              ),
              SizedBox(
                height: 20.0,
              ),
              DetectoHome(
                filho: MyCustomButton(text: "Meus créditos"),
                scale: _scale,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResgateCredito()),
                  );
                },
                ontapDown: _onTapDown,
                ontapUp: _onTapUp,
              ),
              SizedBox(
                height: 20.0,
              ),
              DetectoHome(
                filho: MyCustomButton(text: "Meu QRCODE"),
                scale: _scale,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyQrcode()),
                  );
                },
                ontapDown: _onTapDown,
                ontapUp: _onTapUp,
              ),
            ],
          ),
        ));
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
