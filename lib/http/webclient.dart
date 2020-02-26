import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:migrou_app/interceptors/user_interceptor.dart';


void findAll() async{
  final Client client = HttpClientWithInterceptor.build(interceptors: [LogginInterceptor()]);
  
  var headers = {'Content-Type':'application/json', 'userSession':'1234'};
  final Response response = await client.get("https://migrou-web.herokuapp.com/contaCorrente/3/full", headers: headers);
  
}