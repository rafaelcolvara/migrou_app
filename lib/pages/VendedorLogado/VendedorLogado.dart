import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/Arquivos.dart';
import 'package:migrou_app/componentes/botos_home.dart';
import 'package:migrou_app/pages/Cliente_Logado/WidgetClienteLogado.dart';
import 'package:migrou_app/pages/MenuDeConfiguracao/ConfiguracaoPage.dart';
import 'package:migrou_app/pages/VendedorLogado/MenuAdicionarCliente/AdicionarCliente.dart';
import 'package:migrou_app/pages/VendedorLogado/MenuAdicionarCredito/ListaClientesParaLancarCredito.dart';
import 'package:migrou_app/utils/AutenticationMigrou.dart';
import 'package:migrou_app/utils/definicoes.dart';

import 'MeusClientes.dart';

class VendedorLogado extends StatefulWidget {
  VendedorLogado({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _VendedorLogadoState();
}

class _VendedorLogadoState extends State<VendedorLogado>
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
        title: new Text('Vendedor'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Sair',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: signOut)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DetectoHome(
              ontapDown: _onTapDown,
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddClienteMenu()),
                );
              },
              ontapUp: _onTapUp,
              scale: _scale,
              filho: MyCustomButton(
                  color: Constantes.customColorBlue, text: "Adicionar Cliente"),
            ),
            DetectoHome(
                ontapDown: _onTapDown,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdicinarCreditoClientes()),
                  );
                },
                ontapUp: _onTapUp,
                scale: _scale,
                filho: MyCustomButton(
                    color: Constantes.customColorBlue,
                    text: "Adicionar Crédito")),
            DetectoHome(
                ontapDown: _onTapDown,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VinculadosClientes()),
                  );
                },
                ontapUp: _onTapUp,
                scale: _scale,
                filho: MyCustomButton(
                    color: Constantes.customColorBlue, text: "Meus Clientes")),
            DetectoHome(
                ontapDown: _onTapDown,
                ontap: () {},
                ontapUp: _onTapUp,
                scale: _scale,
                filho: MyCustomButton(
                    color: Constantes.customColorBlue,
                    text: "Créditos Recebidos")),
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
