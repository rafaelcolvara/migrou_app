import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:migrou_app/componentes/FlutterSecureStorage.dart';
import 'package:migrou_app/componentes/SharedPref.dart';
import 'package:migrou_app/http/webclient.dart';
import 'package:migrou_app/model/ClienteVendedoresDTO.dart';
import 'package:migrou_app/model/ContaDTOnew.dart';
import 'package:migrou_app/model/DataResgateDTO.dart';
import 'package:migrou_app/model/EsseDTO.dart';
import 'package:migrou_app/model/LancarCreditoDTO.dart';
import 'package:migrou_app/model/PessoaDTO.dart';
import 'package:migrou_app/model/PessoaFotoDTO.dart';
import 'package:migrou_app/model/PessoaSimplificadaDTO.dart';
import 'package:migrou_app/model/VendedoresViculadorClientes.dart';
import 'package:migrou_app/model/contaDTO.dart';
import 'package:migrou_app/model/infoDTO.dart';
import 'package:migrou_app/pages/Cliente_Logado/ClienteResgateCredito.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/pages/VendedorLogado/MenuAdicionarCliente/AdicionarClientePorEmail.dart';
import 'package:migrou_app/pages/VendedorLogado/VendedorLogado.dart';
import 'package:migrou_app/pages/cliente_logado/ClienteLogado.dart';
import 'package:migrou_app/utils/definicoes.dart';

class PessoaWebClient extends ChangeNotifier {
  SecureStorage secureStorage = SecureStorage();

  Future<PessoaDTO> buscaPessoaPorId(var idPessoa) async {
    var token = await secureStorage.lerSecureData('authToken');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final Response response = await client
        .get(Constantes.HOST_DOMAIN + "/pessoas/id/" + idPessoa.toString(),
            headers: headers)
        .timeout(Duration(seconds: 5));

    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    return PessoaDTO.fromJson(decodedJson);
  }

  Future<Sabata> testando() async {
    var token = await secureStorage.lerSecureData('authToken');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final String _url =
        "${Constantes.HOST_DOMAIN}/vendedor/$userId/buscaClientes";
    final Response response =
        await client.get(_url, headers: headers).timeout(Duration(seconds: 10));
    var decodedJson = jsonDecode(response.body);
    // print(decodedJson);
    return Sabata.fromJson(decodedJson);
  }

//essa list faz um get e retorna os clientes vinculados ao vendedor logado app
//Cliente é um usuario final tipo consumidor.
  Future<List<Clientes>> clientesVinculadosAoVendedor() async {
    var token = await secureStorage.lerSecureData('authToken');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final String _url =
        "${Constantes.HOST_DOMAIN}/vendedor/$userId/buscaClientes";
    final Response response =
        await client.get(_url, headers: headers).timeout(Duration(seconds: 10));
    var decodedJson = jsonDecode(response.body);
    // print("meu body: $decodedJson");
    return decodedJson['clientes'].map<Clientes>((e) {
      return Clientes.fromJson(e);
    }).toList();
  }

  Future<List<MeuDTO>> meusClientesDASH() async {
    var token = await secureStorage.lerSecureData('authToken');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final String _url =
        "${Constantes.HOST_DOMAIN}/contaCorrente/$userId/DashTodosClientes";
    final Response response =
        await client.get(_url, headers: headers).timeout(Duration(seconds: 60));
    var decodedJson = jsonDecode(response.body);
    // print(token);
    return decodedJson.map<MeuDTO>((e) {
      return MeuDTO.fromJson(e);
    }).toList();
  }

  Future<List<DataResgates>> meusClientesCreditoRecebido() async {
    var token = await secureStorage.lerSecureData('authToken');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final String _url =
        "${Constantes.HOST_DOMAIN}/contaCorrente/$userId/BuscaUltimosResgates";
    final Response response =
        await client.get(_url, headers: headers).timeout(Duration(seconds: 10));
    var decodedJson = jsonDecode(response.body);
    // print("meu body: $decodedJson");
    return decodedJson.map<DataResgates>((e) {
      return DataResgates.fromJson(e);
    }).toList();
  }

//essa list faz um get e retorna os vendedores vinculados ao cliente logado app
// vendedor é aquele que vende seus srvicos ou produto.
  Future<List<VendVincCleinteDTO>> vendedoresVinculadosAoCliente() async {
    var token = await secureStorage.lerSecureData('authToken');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final String _url =
        "${Constantes.HOST_DOMAIN}/cliente/$userId/buscaSeusVendedores";
    final Response response =
        await client.get(_url, headers: headers).timeout(Duration(seconds: 30));
    var decodedJson = jsonDecode(response.body);
    // print(decodedJson);
    return decodedJson['vendedores'].map<VendVincCleinteDTO>((e) {
      return VendVincCleinteDTO.fromJson(e);
    }).toList();
  }

//get das informações do cadastro do usuario logado no
//aplicativo seja ele cliente ou vendedor.
  Future<InforDTO> infoCliente() async {
    var token = await secureStorage.lerSecureData('authToken');
    var tipos = await SharedPref().read('tipoPessoa') as String;
    tipos = tipos.toLowerCase();
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final String _url = "${Constantes.HOST_DOMAIN}/$tipos/$userId";
    final Response response =
        await client.get(_url, headers: headers).timeout(Duration(seconds: 10));
    var decodedJson = jsonDecode(response.body);
    // print(decodedJson);
    return InforDTO.fromJson(decodedJson);
  }

//essa chamada da API é para o cliente vrificar o saldo disponivel de credito
  Future<CashBackDTO> saldoResgate() async {
    var token = await secureStorage.lerSecureData('authToken');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final String _url =
        "${Constantes.HOST_DOMAIN}/contaCorrente/$nomeIdVendedor/DashCliente/$userId";
    final Response response =
        await client.get(_url, headers: headers).timeout(Duration(seconds: 10));
    var decodedJson = jsonDecode(response.body);
    // print(decodedJson);
    return CashBackDTO.fromJson(decodedJson);
  }

//essa chamada retorna para o vendedor logado um usuario pelo email cadastrado
  Future<PessoaDTOnew> localizarPorEmail(BuildContext context) async {
    var token = await secureStorage.lerSecureData('authToken');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final String _url = "${Constantes.HOST_DOMAIN}/cliente/$emailUser";
    final Response response =
        await client.get(_url, headers: headers).timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      // print(decodedJson);
      return PessoaDTOnew.fromJson(decodedJson);
    } else {
      // final String responseFail = response.body;
      // print("erro resposte.body: $responseFail");
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Atenção!",
                style: TextStyle(color: Theme.of(context).primaryColor)),
            content: Text("E-mail não localizado",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    height: 1.0,
                    fontWeight: FontWeight.w300)),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

//essa chamanda adiciona um cliente ao vindedor que esta logado no aplicativo
  Future vincularCliente(BuildContext context, String idCliente,
      String idVendedor, Function aDialog) async {
    var token = await secureStorage.lerSecureData('authToken');
    final headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': token
    };
    final body = jsonEncode({
      "cliente": {"username": idCliente},
      "vendedor": {"username": idVendedor}
    });
    final String urlAPI = "${Constantes.HOST_DOMAIN}/vendedor/vinculaCliente";
    final response = await client.patch(urlAPI, headers: headers, body: body);
    final code = response.body;
    aDialog(code);
    return response.body;
  }

//essa chanda API realiza o resgate do
//credito disponivel para o cliente logado no app
  Future resgatarCredito(
      BuildContext context, String idCliente, String idVendedor) async {
    var token = await secureStorage.lerSecureData('authToken');
    final headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': token
    };
    final body = jsonEncode({
      "cliente": {"idCliente": idCliente},
      "vendedor": {"idVendedor": nomeIdVendedor}
    });
    final String urlAPI =
        "${Constantes.HOST_DOMAIN}/contaCorrente/resgate/vendedor/$nomeIdVendedor/cliente/$userId";
    final response = await client.patch(urlAPI, headers: headers, body: body);

    if (response.statusCode == 200) {
      // print("o codigo do resgate é: ${response.statusCode}");
      // final String responseDone = response.body;
      // print(responseDone);
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Atenção!",
                style: TextStyle(color: Theme.of(context).primaryColor)),
            content: Text("Resgate realizado com sucesso.",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    height: 1.0,
                    fontWeight: FontWeight.w300)),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(ClienteLogado());
                },
              ),
            ],
          );
        },
      );
    } else {
      // print(responseFail);
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Atenção!",
                style: TextStyle(color: Theme.of(context).primaryColor)),
            content: Text(response.body,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    height: 1.0,
                    fontWeight: FontWeight.w300)),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

//essa chamada o vendedor logado lanca o credito para seu cliente
  Future lancarCreditoAPI(BuildContext context, String idCliente, String userId,
      double lancamento) async {
    var token = await secureStorage.lerSecureData('authToken');
    final headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': token
    };
    final body = jsonEncode({
      "cliente": {"username": idCliente},
      "valorLancamento": lancamento,
      "vendedor": {"username": userId}
    });
    final String urlAPI = "${Constantes.HOST_DOMAIN}/contaCorrente/";
    final response = await client.post(urlAPI, headers: headers, body: body);

    if (response.statusCode == 200) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Atenção!",
                style: TextStyle(color: Theme.of(context).primaryColor)),
            content: RichText(
                text: TextSpan(
                    text: "Crédito de ",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.red,
                        height: 1.0,
                        fontWeight: FontWeight.w300),
                    children: [
                  TextSpan(
                      text: "R\$ ${lancamento.toStringAsFixed(2)} ",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Constantes.customColorBlue,
                          height: 1.0,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "adicionado com sucesso!",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.red,
                          height: 1.0,
                          fontWeight: FontWeight.w300))
                ])),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      final String responseFail = response.body;
      // print(responseFail);
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Atenção!",
                style: TextStyle(color: Theme.of(context).primaryColor)),
            content: Text(responseFail,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    height: 1.0,
                    fontWeight: FontWeight.w300)),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VendedorLogado()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<List<PessoaDTO>> buscaContaCorrentePorNome(String nome) async {
    var token = await secureStorage.lerSecureData('authToken');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final Response response = await client
        .get(Constantes.HOST_DOMAIN + "/pessoas/nome/" + nome, headers: headers)
        .timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => PessoaDTO.fromJson(json)).toList();
  }

  Future<ClienteVendedoresDTO> buscaVendedoresPorIdCliente({String id}) async {
    var token = await secureStorage.lerSecureData('authToken');
    ClienteVendedoresDTO retorno;
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final Response response = await client
        .get(Constantes.HOST_DOMAIN + "/vendedor/cliente/" + id,
            headers: headers)
        .timeout(Duration(seconds: 50));
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    retorno = ClienteVendedoresDTO.fromJson(decodedJson);
    return retorno;
  }

  Future<PessoaDTO> logaPorEmailSenha(
      {String email, String senha, String tipoPessoa}) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> loginPayload = {
      "username": email,
      "password": senha,
      "tipoPessoa": tipoPessoa
    };

    final Response response = await client
        .post(Constantes.HOST_DOMAIN + "/usuario/login",
            body: jsonEncode(loginPayload), headers: headers)
        .timeout(Duration(seconds: 50));

    if (response.statusCode != 200) {
      throw FormatException(response.body);
    }

    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    PessoaDTO pessoaDTO = PessoaDTO.fromJson(decodedJson);
    secureStorage.salvarSecureData("authToken", pessoaDTO.token);
    secureStorage.salvarSecureData("tipoPessoa", pessoaDTO.tipoPessoa);
    return pessoaDTO;
  }

  Future<PessoaDTO> criarUsuario(BuildContext context,
      {String email,
      String senha,
      String tipoPessoa,
      String telefone,
      String nomeNegocio,
      String ramoAtuacao,
      String nome}) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> cadastroPayload = {
      "email": email,
      "senha": senha,
      "tipoPessoa": tipoPessoa,
      "nrCelular": telefone,
      "nomeNegocio": nomeNegocio,
      "segmentoComercial": ramoAtuacao,
      "nome": nome
    };
    final Response response = await client
        .post(Constantes.HOST_DOMAIN + "/usuario/inclui",
            body: jsonEncode(cadastroPayload), headers: headers)
        .timeout(Duration(seconds: 50));

    if (response.statusCode == 200) {
      return PessoaDTO.fromJson(jsonDecode(response.body));
    }
    return throw new Exception(response.body.toString());
  }

  Future<PessoaSimplificadaDTO> salvaPessoa(PessoaDTO pessoaDTO) async {
    var token = await secureStorage.lerSecureData('authToken');
    final String pessoaJson = jsonEncode(pessoaDTO.toJson());

    Response resposta = await client
        .post(Constantes.HOST_DOMAIN + '/pessoas/inclui',
            headers: {
              'Content-type': 'application/json',
              'Authorization': token,
            },
            body: pessoaJson)
        .timeout(Duration(seconds: 5));
    if (resposta.statusCode == 200) {
      return PessoaSimplificadaDTO.fromJson(jsonDecode(resposta.body));
    }
    return throw new Exception(resposta.body.toString());
  }

  Future<PessoaFotoDTO> salvaFoto(PessoaFotoDTO pessoafotoDTO) async {
    var token = await secureStorage.lerSecureData('authToken');
    final String pessoaJson = jsonEncode(pessoafotoDTO.toJson());
    Response resp = await client.patch(Constantes.HOST_DOMAIN + "/usuario/foto",
        body: pessoaJson,
        headers: {
          'Content-type': 'application/json',
          'Authorization': token,
        });

    return PessoaFotoDTO.fromJson(jsonDecode(resp.body));
  }
}
