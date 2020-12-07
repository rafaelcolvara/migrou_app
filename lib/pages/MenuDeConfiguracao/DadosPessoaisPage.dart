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
      firebase_storage.TaskSnapshot taskSnapshot = await task;
      String urlFotoPerfil = await taskSnapshot.ref.getDownloadURL();
      fotoPerfil = urlFotoPerfil;
      httpServices
          .salvaFoto(PessoaFotoDTO(idPessoa: userId, base64Foto: fotoPerfil));
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
//decodificação da imagem em base64
              String profileIMG = "s";
              // Uint8List bytes = base64.decode(profileIMG);
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
                                  'images/no-image-default.png',
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
                                child: Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/migrouapp.appspot.com/o/791752de-3fa9-4cae-b02f-e2293a1d32bf?alt=media&token=6be5fa4d-011b-4df4-a748-7cdc6fa32fde",
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
