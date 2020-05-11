import 'dart:convert';
import 'package:http/http.dart';
import 'package:migrou_app/model/ClienteDashDTO.dart';
import 'package:migrou_app/utils/definicoes.dart';
import 'package:migrou_app/http/webclient.dart';


class MovimentacaoWebClient {

Future<ClienteDashDTO> buscaDashCliente({String idVendedor, String idCliente}) async{
  
  var headers = {'Content-Type':'application/json', 'userSession':Constantes.TOKEN_ID};
  final String getURL = Constantes.HOST_DOMAIN + "/contaCorrente/" + idVendedor + "/DashCliente/" + idCliente  ;
  final Response response = await client.get( getURL, headers: headers).timeout(Duration(seconds: 5));
  final Map<String,dynamic> decodedJson = jsonDecode(response.body);
  return ClienteDashDTO.fromJson(decodedJson);   
}
}
