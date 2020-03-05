import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class PessoaFotoDTO {

  int idPessoa;
  String byteArrayFoto; 

  PessoaFotoDTO({int idPessoa, this.byteArrayFoto});

  PessoaFotoDTO.fromJson(Map<String, dynamic> json):
    idPessoa = json['idPessoa'],
    byteArrayFoto  = json['byteArrayFoto'];
    
  Map<String, dynamic> toJson() => {
        "idPessoa" :idPessoa,
        "byteArrayFoto": byteArrayFoto
    };

}