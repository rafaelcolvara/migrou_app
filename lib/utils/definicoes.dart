import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';

class Constantes {
  FlutterSecureStorage storage = FlutterSecureStorage();
  static Color customColorBlue = Color.fromARGB(255, 62, 64, 149);
  static Color customColorOrange = Color.fromARGB(255, 245, 134, 52);
  static Color customColorCinza = Color.fromARGB(255, 127, 127, 127);
  static const LARANJA = Color.fromRGBO(235, 134, 52, 1);
  static const CINZA = Color.fromRGBO(230, 231, 232, 2);
  static const AZUL = Colors.blue;
  static const HOST_DOMAIN = "https://migrou-web.herokuapp.com";
  // ignore: non_constant_identifier_names
  static String TOKEN_ID = PessoaWebClient().naha();
}
