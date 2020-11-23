import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:migrou_app/http/webClients/MovimentacaoWebClient.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/pages/VendedorLogado/ChatPage.dart/ChatMenssagem.dart';
import 'package:migrou_app/pages/VendedorLogado/ChatPage.dart/WidgetChat.dart';

class VendedorChatePage extends StatefulWidget {
  final String idCliente;
  final String userId;

  const VendedorChatePage({this.idCliente, this.userId});

  @override
  _VendedorChatePageState createState() => _VendedorChatePageState();
}

class _VendedorChatePageState extends State<VendedorChatePage> {
  void enviarTexto(String text) async {
    FirebaseFirestore.instance
        .collection(userId + idCliente)
        .add({'texto': text, 'id': userId, 'hrEnvio': Timestamp.now()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(userId + idCliente)
                  .orderBy('hrEnvio')
                  .snapshots(),
              builder: (_, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    List<DocumentSnapshot> documentos =
                        snapshot.data.docs.reversed.toList();
                    return ListView.builder(
                      itemCount: documentos.length,
                      reverse: true,
                      itemBuilder: (_, __) {
                        return ChatMenssagem(
                            data: documentos[__].data(),
                            atualUsuario:
                                documentos[__].data()['id'] == userId);
                      },
                    );
                }
              },
            ),
          ),
          ComporTextChat(enviarMensagem: enviarTexto),
        ],
      ),
    );
  }
}
