import 'package:flutter/material.dart';

class ChatMenssagem extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool atualUsuario;
  ChatMenssagem({this.data, this.atualUsuario});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          !atualUsuario
              ? Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/no-image-default.png"),
                  ),
                )
              : Container(),
          Expanded(
              child: Column(
            crossAxisAlignment: atualUsuario
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                data['texto'],
                textAlign: atualUsuario ? TextAlign.end : TextAlign.start,
              ),
            ],
          )),
          atualUsuario
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/no-image-default.png"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
