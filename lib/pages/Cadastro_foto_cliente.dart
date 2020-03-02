import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:migrou_app/controller/pessoa.dart';
import 'package:migrou_app/utils/definicoes.dart';

class CadastraFoto extends StatefulWidget {
  final Pessoa pessoa;

  CadastraFoto({Key key, @required this.pessoa}) : super(key: key);

  @override
  _CadastraFotoState createState() => _CadastraFotoState();
}

class _CadastraFotoState extends State<CadastraFoto> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
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
                  ? Text('Sem foto')
                  : Container(
                      width: 190.0,
                      height: 190.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              image: FileImage(_image), fit: BoxFit.fill)),
                    ),
            ),
            Text(
              widget.pessoa.nome,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Tw Cen MT', fontSize: 20.0)
                  .copyWith(color: Constantes.AZUL, fontWeight: FontWeight.bold),
            ),
            Text(
              'Aniversario: ' + widget.pessoa.dataNascimento.day.toString() + '/' +  widget.pessoa.dataNascimento.month.toString() ,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Tw Cen MT', fontSize: 20.0)
                  .copyWith(color: Constantes.AZUL, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.pessoa.email,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Tw Cen MT', fontSize: 20.0)
                  .copyWith(color: Constantes.AZUL, fontWeight: FontWeight.bold),
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
