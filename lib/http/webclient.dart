import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:migrou_app/http/user_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LogginInterceptor()],
);




