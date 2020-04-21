import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:migrou_app/componentes/Alerta.dart';
import 'package:migrou_app/componentes/Arquivos.dart';
import 'package:migrou_app/componentes/DateComponente.dart';
import 'package:migrou_app/controller/controller.dart';
import 'package:migrou_app/controller/ctrl.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/PessoaDTO.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

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
  File _image;
  String _base64Arquivo;
  Arquivos arquivoCelular = new Arquivos();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });

    List<int> teste = _image.readAsBytesSync();
    _base64Arquivo = base64.encode(teste);
    controller.pessoa.changeFoto(_base64Arquivo);
  }

  Future<String> _saveCliente() async {
    String retorno;
    await _webClient
        .salvaPessoa(new PessoaDTO(
            id: controller.pessoa.idPessoa,
            nome: controller.pessoa.nome,
            dataNascimento: controller.pessoa.dataNascimento,
            dataCadastro: DateTime.now(),
            email: controller.pessoa.email,
            senha: controller.pessoa.senha,
            nrCelular: controller.pessoa.nrCelular,
            base64Foto: controller.pessoa.base64Foto))
        .then((pessoa) {
      retorno = pessoa.nome + ", MIGROU!";
    }).catchError((e) {
      retorno = e.toString();
      throw e;
    });
    return retorno;
  }

  _textField(
      {String labelText,
      onChanged,
      String Function() errorText,
      bool flgSenha = false}) {
    return TextField(
      onChanged: onChanged,
      obscureText: flgSenha,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
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
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Center(
            child: _image == null
                ? Padding(
                    padding: const EdgeInsets.all(78.0),
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                        width: 190.0,
                        height: 190.0,
                        alignment: Alignment(0.0, 0.0),
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 1.5, color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          image: DecorationImage(
                              image: AssetImage('images/no-image-default.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ))
                : Container(
                    width: 190.0,
                    height: 190.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 1.5, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      image: new DecorationImage(
                          image: FileImage(_image), fit: BoxFit.fill),
                    ),
                  ),
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
          Observer(builder: (_) {
            return DateTimePicker(
                labelText: "Nascimento",
                selectedDate: controller.pessoa.dataNascimento,
                selectDate: controller.pessoa.changeDataDascimento);
          }),
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
                  onChanged: controller.pessoa.chageSenha,
                  flgSenha: true);
            },
          ),
          _cadastrarUsuario(context),
        ],
      ),
    );
  }

  _cadastrarUsuario(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(15.0),
        color: Constantes.AZUL,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            
            await _saveCliente().then((value) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertaDialogo( flgOk: true, textoMensagem: value,);
                  });              
            }).catchError((e) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertaDialogo(flgOk: false, textoMensagem:  "Email ja Cadastrado");
                  });
            });
            await arquivoCelular.writeContent("CLIENTE");

          },
          child: Text("Inclui",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
