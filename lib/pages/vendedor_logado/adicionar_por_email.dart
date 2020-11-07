import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';

class AddPorEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PessoaWebClient httpService = PessoaWebClient();
    return Scaffold(
      appBar: AppBar(title: const Text("Vincular Cliente"), centerTitle: true),
      body: FutureBuilder(),
    );
  }
}
