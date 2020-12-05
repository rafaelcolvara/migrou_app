import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/infoDTO.dart';
import 'package:migrou_app/pages/LoginPageAPI.dart';
import 'package:migrou_app/utils/definicoes.dart';

class DadosPessoais extends StatefulWidget {
  @override
  _DadosPessoaisState createState() => _DadosPessoaisState();
}

class _DadosPessoaisState extends State<DadosPessoais> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() async {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child(userId)
          .putFile(_image);
      await task;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PessoaWebClient httpServer = PessoaWebClient();
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: httpServer.infoCliente(),
          builder: (_, AsyncSnapshot<InforDTO> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot.error);
              if (!snapshot.hasData)
                return Center(child: Text("Ops...\nVerifique sua conexão!"));
//decodificação da imagem em base64
              String profileIMG = snapshot.data.base64Foto;
              Uint8List bytes = base64.decode(profileIMG);
//conversão do telelefone para formato (ddd)12345-6789
              var ddd = snapshot.data.nrCelular.substring(0, 2);
              var teleP1 = snapshot.data.nrCelular.substring(2, 7);
              var teleP2 = snapshot.data.nrCelular.substring(7, 11);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    profileIMG == null || profileIMG == ""
                        ? Stack(
                            children: [
                              Container(
                                child: Image.asset(
                                  'images/pati.png',
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * 0.26,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                ),
                              ),
                              Positioned(
                                  bottom: -8,
                                  right: 0,
                                  child: IconButton(
                                      iconSize: 32,
                                      color: Constantes.customColorOrange,
                                      icon: Icon(Icons.camera),
                                      onPressed: getImage))
                            ],
                          )
                        : Stack(
                            children: [
                              Container(
                                width: 80,
                                height: 120,
                                child: Image.memory(
                                  bytes,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: IconButton(
                                      icon: Icon(Icons.camera),
                                      onPressed: () {}))
                            ],
                          ),
                    SizedBox(height: 10),
                    Text("Nome: ${snapshot.data.nome}"),
                    SizedBox(height: 10),
                    Text("Data Nascimento: ${snapshot.data.dataNascimento}"),
                    SizedBox(height: 10),
                    Text("Tel: ($ddd) $teleP1-$teleP2"),
                    SizedBox(height: 10),
                    Text("E-mail: ${snapshot.data.email}"),
                    SizedBox(width: 10),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
