import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/utils/definicoes.dart';

class CriarContaPage extends StatefulWidget {
  @override
  _CriarContaPageState createState() => _CriarContaPageState();
}

class _CriarContaPageState extends State<CriarContaPage> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int theriGroupVakue;

  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text("Vendedor"),
    1: Text("Cliente")
  };

  String tipo;

  build(BuildContext context) {
    final TextEditingController nomeControle = TextEditingController();
    final TextEditingController telefoneControle = TextEditingController();
    final TextEditingController emailControle = TextEditingController();
    final TextEditingController senhaControle = TextEditingController();
    final TextEditingController nomeNegocioControle = TextEditingController();
    final TextEditingController ramoAtuacaoControle = TextEditingController();
    PessoaWebClient httpService = PessoaWebClient();
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
          child: theriGroupVakue == 1
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
    return ListView(
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
              return 'Telefone Invalido';
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
            if (senha.isEmpty || senha.length < 6) return 'Senha Invalida';
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
                groupValue: theriGroupVakue,
                onValueChanged: (changeFromGroupValue) {
                  setState(() {
                    theriGroupVakue = changeFromGroupValue;
                    tipo = theriGroupVakue != 0 ? "CLIENTE" : "VENDEDOR";
                    print('setou para $changeFromGroupValue é $tipo');
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
        senhaControle.text == "Senha"
            ? RaisedButton(
                color: Constantes.customColorCinza,
                onPressed: null,
                child: const Text(
                  'Criar Conta',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              )
            : RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    httpService.criarUsuario(context,
                        nome: nomeControle.text,
                        telefone: telefoneControle.text,
                        email: emailControle.text,
                        senha: senhaControle.text,
                        tipoPessoa: tipo);
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
    return ListView(
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
          controller: nomeNegocioControle,
          decoration: const InputDecoration(
              hintText: 'Seu nome negócio', border: InputBorder.none),
          keyboardType: TextInputType.name,
          validator: (nomeNegocio) {
            if (nomeNegocio.isEmpty || nomeNegocio.length < 3)
              return 'Nome de negócio invalido';
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
              hintText: 'Ramo de atuação', border: InputBorder.none),
          keyboardType: TextInputType.name,
          validator: (nomeRamoAtuacao) {
            if (nomeRamoAtuacao.isEmpty || nomeRamoAtuacao.length < 3)
              return 'Ramo de atuação inválido';
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
            if (nomeV.isEmpty || nomeV.length < 3) return 'Nome inválido';
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
              return 'Telefone inválido';
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
            if (!emailValidador(emailV)) return 'E-mail inválido';
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
              return 'Senha deve ter mais de 6 caracteres';
            return null;
          },
          autocorrect: false,
        ),
        theriGroupVakue == null
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
                          hintText: 'Seu nome Fantasia',
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
                      controller: nomeControle,
                      decoration: const InputDecoration(
                          hintText: 'Seu Nome', border: InputBorder.none),
                      keyboardType: TextInputType.name,
                      validator: (nomeV) {
                        if (nomeV.isEmpty || nomeV.length < 3)
                          return 'Nome Invalido';
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
                          return 'Telefone Invalido';
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
                        if (!emailValidador(emailV)) return 'E-mail Invalido';
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
                          return 'Senha Invalida';
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
                groupValue: theriGroupVakue,
                onValueChanged: (changeFromGroupValue) {
                  setState(() {
                    theriGroupVakue = changeFromGroupValue;
                    tipo = theriGroupVakue != 0 ? "CLIENTE" : "VENDEDOR";
                    print('setou para $changeFromGroupValue é $tipo');
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
        theriGroupVakue == null
            ? RaisedButton(
                color: Constantes.customColorCinza,
                onPressed: null,
                child: const Text(
                  'Criar Conta',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              )
            : RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    await httpService.criarUsuario(context,
                        nome: nomeControle.text,
                        telefone: telefoneControle.text,
                        email: emailControle.text,
                        nomeNegocio: nomeNegocioControle.text,
                        ramoAtuacao: ramoAtuacaoControle.text,
                        senha: senhaControle.text,
                        tipoPessoa: tipo);
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
