import 'package:http_interceptor/http_interceptor.dart';

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
      print('body: ${data.body}');
      return data;
  }

}