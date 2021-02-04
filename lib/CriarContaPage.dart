import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/utils/definicoes.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CriarContaPage extends StatefulWidget {
  @override
  _CriarContaPageState createState() => _CriarContaPageState();
}

class _CriarContaPageState extends State<CriarContaPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  int flgOptonButton;

  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text("Vendedor"),
    1: Text("Cliente")
  };

  String tipo;
  PessoaWebClient httpService = PessoaWebClient();
  final TextEditingController nomeControle = TextEditingController();
  final MaskedTextController telefoneControle = MaskedTextController(
    mask: '(00) 00000-0000',
  );
  final TextEditingController emailControle = TextEditingController();
  final TextEditingController senhaControle = TextEditingController();
  final TextEditingController nomeNegocioControle = TextEditingController();
  final TextEditingController ramoAtuacaoControle = TextEditingController();

  bool isLoading = false;

  build(BuildContext context) {
    return Scaffold(
      backgroundColor: (Theme.of(context).primaryColor),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: Center(
          child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: flgOptonButton == 1
              ? formCliente(context, nomeControle, telefoneControle,
                  emailControle, senhaControle, httpService)
              : formVendedor(
                  context,
                  nomeControle,
                  nomeNegocioControle,
                  ramoAtuacaoControle,
                  telefoneControle,
                  emailControle,
                  senhaControle,
                  httpService),
        ),
      )),
    );
  }

  ListView formCliente(
      BuildContext context,
      TextEditingController nomeControle,
      TextEditingController telefoneControle,
      TextEditingController emailControle,
      TextEditingController senhaControle,
      PessoaWebClient httpService) {
    return isLoading
        ? ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(child: CircularProgressIndicator()),
                ),
              ),
              Center(
                child: Text(
                  "Aguarde...",
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        : ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.asset("images/logo.png", fit: BoxFit.contain),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              TextFormField(
                controller: nomeControle,
                decoration: const InputDecoration(
                    hintText: 'Seu Nome', border: InputBorder.none),
                keyboardType: TextInputType.name,
                validator: (nome) {
                  if (nome.isEmpty || nome.length < 3) return 'Nome Invalido';
                  return null;
                },
                autocorrect: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextFormField(
                controller: telefoneControle,
                decoration: const InputDecoration(
                    hintText: 'Telefone', border: InputBorder.none),
                keyboardType: TextInputType.phone,
                validator: (telefone) {
                  if (telefone.isEmpty || telefone.length < 10)
                    return 'Telefone deve ter 11 digitos (ddd+numero)';
                  return null;
                },
                autocorrect: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextFormField(
                controller: emailControle,
                decoration: const InputDecoration(
                    hintText: 'E-mail', border: InputBorder.none),
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (!emailValidador(email)) return 'E-mail Invalido';
                  return null;
                },
                autocorrect: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextFormField(
                controller: senhaControle,
                decoration: const InputDecoration(
                    hintText: 'Senha', border: InputBorder.none),
                obscureText: true,
                validator: (senha) {
                  if (senha.isEmpty || senha.length < 6)
                    return 'Senha Invalida';
                  return null;
                },
                autocorrect: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: CupertinoSegmentedControl(
                      selectedColor: Theme.of(context).primaryColor,
                      groupValue: flgOptonButton,
                      onValueChanged: (changeFromGroupValue) {
                        setState(() {
                          flgOptonButton = changeFromGroupValue;
                          tipo = flgOptonButton != 0 ? "CLIENTE" : "VENDEDOR";
                        });
                      },
                      children: logoWidgets,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    httpService
                        .criarUsuario(context,
                            nome: nomeControle.text,
                            telefone: telefoneControle.text,
                            email: emailControle.text,
                            senha: senhaControle.text,
                            tipoPessoa: tipo)
                        .then((value) => {
                              setState(() {
                                isLoading = false;
                              }),
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: new Text("Atenção!",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    content: Text(
                                        "Cadastro Realizado com Sucesso",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.red,
                                            height: 1.0,
                                            fontWeight: FontWeight.w300)),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: new Text("OK"),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, "/RootPage");
                                        },
                                      ),
                                    ],
                                  );
                                },
                              )
                            });
                  }
                },
                child: const Text(
                  'Criar Conta',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              )
            ],
          );
  }

  ListView formVendedor(
      BuildContext context,
      TextEditingController nomeControle,
      TextEditingController nomeNegocioControle,
      TextEditingController ramoAtuacaoControle,
      TextEditingController telefoneControle,
      TextEditingController emailControle,
      TextEditingController senhaControle,
      PessoaWebClient httpService) {
    return isLoading
        ? ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(child: CircularProgressIndicator()),
                ),
              ),
              Center(
                child: Text(
                  "Aguarde...",
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        : ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.asset("images/logo.png", fit: BoxFit.contain),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              flgOptonButton == null
                  ? Center(
                      child: Text(
                      'Escolha o tipo de conta!',
                      style: TextStyle(fontSize: 18),
                    ))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nomeNegocioControle,
                            decoration: const InputDecoration(
                                hintText: 'Nome do Negócio',
                                border: InputBorder.none),
                            keyboardType: TextInputType.name,
                            validator: (nomeNegocio) {
                              if (nomeNegocio.isEmpty || nomeNegocio.length < 3)
                                return 'Nome Invalido';
                              return null;
                            },
                            autocorrect: false,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          TextFormField(
                            controller: ramoAtuacaoControle,
                            decoration: const InputDecoration(
                                hintText: 'Ramo de atuação',
                                border: InputBorder.none),
                            keyboardType: TextInputType.name,
                            validator: (ramoAtuacao) {
                              if (ramoAtuacao.isEmpty || ramoAtuacao.length < 3)
                                return 'Ramo de atuação não pode ser vazio';
                              return null;
                            },
                            autocorrect: false,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          TextFormField(
                            controller: nomeControle,
                            decoration: const InputDecoration(
                                hintText: 'Seu Nome', border: InputBorder.none),
                            keyboardType: TextInputType.name,
                            validator: (nomeV) {
                              if (nomeV.isEmpty || nomeV.length < 3)
                                return 'Nome não pode ser vazio';
                              return null;
                            },
                            autocorrect: false,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          TextFormField(
                            controller: telefoneControle,
                            decoration: const InputDecoration(
                                hintText: 'Telefone', border: InputBorder.none),
                            keyboardType: TextInputType.phone,
                            validator: (telefoneV) {
                              if (telefoneV.isEmpty || telefoneV.length < 10)
                                return 'Telefone não pode ser vazio';
                              return null;
                            },
                            autocorrect: false,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          TextFormField(
                            controller: emailControle,
                            decoration: const InputDecoration(
                                hintText: 'E-mail', border: InputBorder.none),
                            keyboardType: TextInputType.emailAddress,
                            validator: (emailV) {
                              if (!emailValidador(emailV))
                                return 'E-mail Invalido';
                              return null;
                            },
                            autocorrect: false,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          TextFormField(
                            controller: senhaControle,
                            decoration: const InputDecoration(
                                hintText: 'Senha', border: InputBorder.none),
                            obscureText: true,
                            validator: (senhaV) {
                              if (senhaV.isEmpty || senhaV.length < 6)
                                return 'Senha deve conter no mínimo 6 caracteres';
                              return null;
                            },
                            autocorrect: false,
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: CupertinoSegmentedControl(
                      selectedColor: Theme.of(context).primaryColor,
                      groupValue: flgOptonButton,
                      onValueChanged: (changeFromGroupValue) {
                        setState(() {
                          flgOptonButton = changeFromGroupValue;
                          tipo = flgOptonButton != 0 ? "CLIENTE" : "VENDEDOR";
                        });
                      },
                      children: logoWidgets,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              flgOptonButton == null
                  ? RaisedButton(
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      color: Constantes.customColorCinza,
                      onPressed: null,
                      child: const Text(
                        'Criar Conta',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  : RaisedButton(
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          httpService
                              .criarUsuario(context,
                                  nomeNegocio: nomeNegocioControle.text,
                                  ramoAtuacao: ramoAtuacaoControle.text,
                                  nome: nomeControle.text,
                                  telefone: telefoneControle.text,
                                  email: emailControle.text,
                                  senha: senhaControle.text,
                                  tipoPessoa: tipo)
                              .then((value) => {
                                    setState(() {
                                      isLoading = false;
                                    }),
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: new Text("Atenção!",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          content: Text(
                                              "Cadastro Realizado com Sucesso",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.red,
                                                  height: 1.0,
                                                  fontWeight: FontWeight.w300)),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: new Text("OK"),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, "/RootPage");
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                  });
                        }
                      },
                      child: const Text(
                        'Criar Conta',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
            ],
          );
  }

  bool emailValidador(String email) {
    final RegExp regex = RegExp(
        r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
    return regex.hasMatch(email);
  }
}
