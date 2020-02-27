import 'dart:convert';

import 'package:http/http.dart';
import 'package:migrou_app/http/webclient.dart';
import 'package:migrou_app/model/PessoaDTO.dart';
import 'package:migrou_app/utils/definicoes.dart';


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

Future<PessoaDTO> save(PessoaDTO pessoaDTO) async {
    final String pessoaJson = jsonEncode(pessoaDTO.toJson());

    final Response response = await client.post(Constantes.HOST_DOMAIN + 'pessoas/inclui',
        headers: {
          'Content-type': 'application/json',
          'userSession': '1000',
        },
        body: pessoaJson);

    return PessoaDTO.fromJson(jsonDecode(response.body));
  }
