import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/PessoaFotoDTO.dart';
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
  String fotoPerfil;
  PessoaWebClient httpServices = PessoaWebClient();
  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 67);

    setState(() async {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
        return null;
      }
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child(userId)
          .putFile(_image);
      firebase_storage.TaskSnapshot taskSnapshot = await task;
      String urlFotoPerfil =
          await taskSnapshot.ref.child(userId).getDownloadURL();
      fotoPerfil = urlFotoPerfil;
      httpServices
          .salvaFoto(PessoaFotoDTO(username: userId, urlFoto: fotoPerfil));
    });
  }

  @override
  Widget build(BuildContext context) {
    final PessoaWebClient httpServer = PessoaWebClient();
    return Scaffold(
        appBar:
            AppBar(title: const Text("Dados Cadastrais"), centerTitle: true),
        body: FutureBuilder(
          future: httpServer.infoCliente(),
          builder: (_, AsyncSnapshot<InforDTO> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot.error);
              if (!snapshot.hasData)
                return Center(child: Text("Ops...\nVerifique sua conexão!"));
              String profileIMG = snapshot.data.urlFoto;
              var ddd = snapshot.data.nrCelular.substring(0, 2);
              var teleP1 = snapshot.data.nrCelular.substring(2, 7);
              var teleP2 = snapshot.data.nrCelular.substring(7, 11);
              return ListView(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          profileIMG == null || profileIMG == ""
                              ? Stack(
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        'images/no-image-default.png',
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.26,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
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
                                      child: Image.network(
                                        profileIMG,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.45,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.80,
                                      ),
                                    ),
                                    Positioned(
                                        bottom: -8,
                                        right: 0,
                                        child: IconButton(
                                            iconSize: 35,
                                            color: Constantes.customColorOrange,
                                            icon: Icon(Icons.camera),
                                            onPressed: getImage))
                                  ],
                                ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04),
                          Text("Nome: ${snapshot.data.nome}"),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04),
                          Text("Tel: ($ddd) $teleP1-$teleP2"),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04),
                          Text("E-mail: ${snapshot.data.username}"),
                          SizedBox(
                              width: MediaQuery.of(context).size.height * 0.06),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
