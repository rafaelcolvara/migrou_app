import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:migrou_app/model/PessoaDTO.dart';
import 'package:migrou_app/model/PessoaFotoDTO.dart';
import 'package:migrou_app/utils/definicoes.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';


class CadastraFoto extends StatefulWidget {
  final PessoaDTO pessoa;

  CadastraFoto({Key key, @required this.pessoa}) : super(key: key);

  @override
  _CadastraFotoState createState() => _CadastraFotoState();
}

class _CadastraFotoState extends State<CadastraFoto> {
  
  File _image;
  String _base64Arquivo;

  final PessoaWebClient _webPessoa = PessoaWebClient();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;        
    });

    carregafoto();
  }

  void carregafoto() async  {

      List<int> teste  = _image.readAsBytesSync();
      _base64Arquivo = base64.encode(teste);    
      
      
      PessoaFotoDTO pessoaFoto = new PessoaFotoDTO();
      pessoaFoto.idPessoa =widget.pessoa.id;
      pessoaFoto.byteArrayFoto =_base64Arquivo;
      
      _webPessoa.salvaFoto(pessoaFoto);
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foto do perfil'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Center(
              child: _image == null
                  ? Padding(
                    padding: const EdgeInsets.all(78.0),
                    child: Text('Sem foto'),
                  )
                  : Container(
                      width: 190.0,
                      height: 190.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 1.5, color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          image: new DecorationImage(
                              image: FileImage(_image), fit: BoxFit.fill)),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                widget.pessoa.nome,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Tw Cen MT', fontSize: 26.0)
                    .copyWith(color: Constantes.AZUL, fontWeight: FontWeight.bold),
              ),
            ),            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "email: " + widget.pessoa.email,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Tw Cen MT', fontSize: 20.0)
                    .copyWith(color: Constantes.AZUL, fontWeight: FontWeight.normal),
              ),
            ),                      
            Text(
                'Aniversário: ' + widget.pessoa.dataAniversarioFormatada(),
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Tw Cen MT', fontSize: 20.0)
                    .copyWith(color: Constantes.AZUL, fontWeight: FontWeight.normal),
              ),            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,        
        tooltip: 'Selecione uma imagem',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
