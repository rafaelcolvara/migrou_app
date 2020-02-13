import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:migrou_app/controller/controller.dart';
import 'package:migrou_app/controller/ctrl.dart';

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
        title: new Text(labelText,
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children: <Widget>[
                  Observer(
                    builder: (_) {
                      return _textField(
                          labelText: "Nome",
                          errorText: controller.validaName,
                          onChanged: controller.cliente.changeName);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Observer(
                    builder: (_) {
                      return _textField(
                          labelText: "Email",
                          errorText: controller.validaEmail,
                          onChanged: controller.cliente.changeEmail);
                    },
                  ),
                  SizedBox(
                    height: 20,
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
                      padding: new EdgeInsets.all(12.0),
                      child: new Center(
                        child: new Column(
                            children: <Widget>[
                              _optionSwith(
                                labelText: controller.nomeLabelSwith(),
                                valor: controller.cliente.flgVendedor,
                                onChanged: controller.cliente.changeVendedor,
                              )]
                        ),
                      ),
                    );
                  })
                ])
        )
    );
  }
}