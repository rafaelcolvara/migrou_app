import 'package:http_interceptor/http_interceptor.dart';
import 'dart:convert' show utf8;


class LogginInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('*** Request ****');
    print('url: ${data.baseUrl}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
      print('#### Response #####');
      print('status code: ${data.statusCode}');
      print('headers: ${data.headers}');
      data.body = conversao(data.body);
      return data;
  }

  static String conversao(String texto){
      List<int> bytes = texto.toString().codeUnits;
      return utf8.decode(bytes);
    }

}