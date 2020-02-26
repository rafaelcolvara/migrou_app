import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:migrou_app/controller/controller.dart';
import 'package:migrou_app/controller/ctrl.dart';
import 'package:migrou_app/utils/definicoes.dart';

class Cadastro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CadastroUsuario();
  }
}

class _CadastroUsuario extends State<Cadastro> {
  final controller = Controller();
  final ctrl = Ctrl();

  _textField({String labelText, onChanged, String Function() errorText}) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        errorText: errorText == null ? null : errorText(),
      ),
    );
  }

  _optionSwith({String labelText, onChanged, bool valor}) {
    return SwitchListTile(
        value: valor,
        onChanged: onChanged,
        title: new Text(
          labelText,
          style: new TextStyle(
              fontWeight: FontWeight.bold, color: Colors.deepOrange),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Novo Cadastro'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Observer(
                    builder: (_) {
                      return _textField(
                          labelText: "Nome",
                          errorText: controller.validaName,
                          onChanged: controller.cliente.changeName);
                    },
                  ),
                  Observer(
                    builder: (_) {
                      return _textField(
                          labelText: "Email",
                          errorText: controller.validaEmail,
                          onChanged: controller.cliente.changeEmail);
                    },
                  ),
                  Observer(
                    builder: (_) {
                      return _textField(
                          labelText: "Cpf",
                          errorText: controller.validaCpf,
                          onChanged: controller.cliente.changeCpf);
                    },
                  ),
                  Observer(builder: (_) {
                    return Padding(
                      padding: new EdgeInsets.all(8.0),
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
                  _CadastrarUsuario(context),
                ])));
  }

  _CadastrarUsuario(BuildContext context) {
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Color.fromRGBO(62, 64, 149, 1),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          
        },
        child: Text("Gravar",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
