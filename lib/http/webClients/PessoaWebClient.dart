import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:migrou_app/http/webclient.dart';
import 'package:migrou_app/model/ClienteVendedoresDTO.dart';
import 'package:migrou_app/model/PessoaDTO.dart';
import 'package:migrou_app/model/PessoaFotoDTO.dart';
import 'package:migrou_app/model/PessoaSimplificadaDTO.dart';
import 'package:migrou_app/utils/definicoes.dart';


class PessoaWebClient {
Future<PessoaDTO> buscaPessoaPorId(var idPessoa) async{
  
  var headers = {'Content-Type':'application/json', 'userSession':Constantes.TOKEN_ID};
  final Response response = await client.
      get(Constantes.HOST_DOMAIN + "/pessoas/id/" + idPessoa.toString(), headers: headers).
      timeout(Duration(seconds: 5));
      
  final Map<String,dynamic> decodedJson = jsonDecode(response.body);
  return PessoaDTO.fromJson(decodedJson);
}

Future<List<PessoaDTO>> buscaContaCorrentePorNome(String nome) async{
  
  var headers = {'Content-Type':'application/json', 'userSession':Constantes.TOKEN_ID};
  final Response response = await client.get(Constantes.HOST_DOMAIN + "/pessoas/nome/" + nome, headers: headers).timeout(Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  return decodedJson.map((dynamic json) => PessoaDTO.fromJson(json)).toList(); 
  
}

Future<ClienteVendedoresDTO> buscaVendedoresPorIdCliente({String id}) async{
  
  ClienteVendedoresDTO retorno;
  var headers = {'Content-Type':'application/json', 'userSession':Constantes.TOKEN_ID};
  final Response response = await client.get(Constantes.HOST_DOMAIN + "/vendedor/cliente/" + id , headers: headers).timeout(Duration(seconds: 10));
  final Map<String,dynamic> decodedJson = jsonDecode(response.body);
  retorno = ClienteVendedoresDTO.fromJson(decodedJson); 
  return retorno;
  
}

Future<PessoaDTO> logaPorEmailSenha({String email, String senha, String tipoPessoa}) async{
  
  var headers = {'Content-Type':'application/json', 'userSession':Constantes.TOKEN_ID};
  Map<String, dynamic> loginPayload = {  "email": email,  "senha": senha, "tipoPessoa": tipoPessoa};

  PessoaDTO retorno;

  final Response response = await client.
      post(Constantes.HOST_DOMAIN + "/pessoas/login", 
      body: jsonEncode(loginPayload),
      headers: headers).
      timeout(Duration(seconds: 10));

      if (response.statusCode == 500) {
        throw FormatException(response.body);
      }

      final Map<String,dynamic> decodedJson = jsonDecode(response.body);
      retorno= PessoaDTO.fromJson(decodedJson);

    return retorno;
  
}

Future<PessoaSimplificadaDTO> salvaPessoa(PessoaDTO pessoaDTO) async {
    final String pessoaJson = jsonEncode(pessoaDTO.toJson());
    
    Response resposta  = await client.post(Constantes.HOST_DOMAIN + '/pessoas/inclui',
    headers: {
      'Content-type': 'application/json',
      'userSession': Constantes.TOKEN_ID,
    },
    body: pessoaJson).timeout(Duration(seconds: 5));
    if (resposta.statusCode == 200){
      return PessoaSimplificadaDTO.fromJson(jsonDecode(resposta.body));
    }
    return throw new Exception(resposta.body.toString());
  }

  Future<PessoaFotoDTO> salvaFoto(PessoaFotoDTO pessoafotoDTO) async {
    
    final String pessoaJson = jsonEncode(pessoafotoDTO.toJson());
    Response resp  = await client.patch(Constantes.HOST_DOMAIN + "/pessoas/foto", body: pessoaJson,
    headers: {
          'Content-type': 'application/json',
          'userSession': Constantes.TOKEN_ID,
        });

    return PessoaFotoDTO.fromJson(jsonDecode(resp.body));
  }






}


