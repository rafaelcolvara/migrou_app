import 'dart:convert';
import 'package:http/http.dart';
import 'package:migrou_app/componentes/FlutterSecureStorage.dart';
import 'package:migrou_app/model/ClienteDashDTO.dart';
import 'package:migrou_app/utils/definicoes.dart';
import 'package:migrou_app/http/webclient.dart';

var idVendedor = "";
var idCliente = "";

class MovimentacaoWebClient {
  SecureStorage secureStorage = SecureStorage();
  Future<ClienteDashDTO> buscaDashCliente(
      {String idVendedor, String idCliente}) async {
    var token = await secureStorage.lerSecureData('authToken');
    var headers = {'Content-Type': 'application/json', 'Authorizarion': token};
    final String getURL = Constantes.HOST_DOMAIN +
        "/contaCorrente/" +
        idVendedor +
        "/DashCliente/" +
        idCliente;
    final Response response = await client
        .get(getURL, headers: headers)
        .timeout(Duration(seconds: 5));
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    return ClienteDashDTO.fromJson(decodedJson);
  }
}
