import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:migrou_app/componentes/DateComponente.dart';
import 'package:migrou_app/controller/controller.dart';
import 'package:migrou_app/controller/ctrl.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/PessoaDTO.dart';

import 'package:migrou_app/componentes/Componentes.dart';
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
  final PessoaWebClient _webClient = PessoaWebClient();
  final DateTimePicker dataAqui = DateTimePicker();


  _textField(
      {String labelText,
      onChanged,
      String Function() errorText,
      bool flgSenha = false}) {
    return TextField(
      onChanged: onChanged,
      obscureText: flgSenha,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        errorText: errorText == null ? null : errorText(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Informe seus dados para login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: logoMigrou(context),
            ),            
            slogan(context),
            Observer(
              builder: (_) {
                return _textField(
                    labelText: "Nome",
                    errorText: controller.validaName,
                    onChanged: controller.pessoa.changeName);
              },
            ),
            Observer(
              builder: (_) {
                return _textField(
                    labelText: "Email",
                    errorText: controller.validaEmail,
                    onChanged: controller.pessoa.changeEmail);
              },
            ),
            Observer(
              builder: (_) {
                return _textField(
                    labelText: "senha",
                    errorText: controller.validaSenha,
                    onChanged: controller.pessoa.chageSenha);                    
              },
            ),
            Observer(builder: (_) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
                child: Center(
                  child: DateTimePicker(
                    labelText: "Data de Nascimento",
                    selectedDate: controller.pessoa.dataNascimento,
                    selectDate: controller.pessoa.changeDataDascimento       
                  ),
                ),
              );
            }),
            _cadastrarUsuario(context),
          ],
        ),
      ),
    );
  }

  _cadastrarUsuario(BuildContext context) {
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Constantes.AZUL,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _webClient
              .salvaPessoa(new PessoaDTO(
                  0,
                  controller.pessoa.nome,
                  DateTime.now(),
                  DateTime.now(),
                  controller.pessoa.email,
                  'senha'))
              .then((pessoa) {
            if (pessoa != null) {
              Navigator.pop(context);
            }
          });
        },
        child: Text("Gravar",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
