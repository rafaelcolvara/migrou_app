import 'package:http_interceptor/http_interceptor.dart';

class LogginInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    if (data.method==Method.PATCH){
      print(data.body);      
    }
    print('enviou');    
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
      print('recebeu $data' + data.statusCode.toString());
      return data;
  }

}