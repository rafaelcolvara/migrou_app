import 'package:flutter/material.dart';
import 'package:migrou_app/utils/definicoes.dart';

class ComporTextChat extends StatefulWidget {
  final Function(String) enviarMensagem;
  ComporTextChat({
    this.enviarMensagem,
  });

  @override
  _ComporTextChatState createState() => _ComporTextChatState();
}

final TextEditingController _controller = TextEditingController();
bool digitouTexto = false;

class _ComporTextChatState extends State<ComporTextChat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(children: [
        IconButton(
          icon: Icon(Icons.camera),
          onPressed: () {},
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration.collapsed(
                hintText: "Enviar Mensagem para o Vendedor"),
            onChanged: (text) {
              setState(() {
                digitouTexto = text.isNotEmpty;
              });
            },
            onSubmitted: digitouTexto == false && _controller.text == null ||
                    _controller.text == ""
                ? (text) {}
                : (text) {
                    widget.enviarMensagem(text);
                    _controller.clear();
                    setState(() {
                      digitouTexto = false;
                    });
                  },
          ),
        ),
        digitouTexto == false && _controller.text == null ||
                _controller.text == ""
            ? IconButton(
                icon: Icon(Icons.send, color: Constantes.customColorCinza),
                onPressed: null,
              )
            : IconButton(
                icon: Icon(Icons.send, color: Constantes.customColorOrange),
                onPressed: () {
                  widget.enviarMensagem(_controller.text);
                  _controller.clear();
                  setState(() {
                    digitouTexto = false;
                  });
                },
              ),
      ]),
    );
  }
}
