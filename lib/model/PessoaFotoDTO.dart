import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class PessoaFotoDTO {
  String username;
  String urlFoto;

  PessoaFotoDTO({this.username, this.urlFoto});

  PessoaFotoDTO.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        urlFoto = json['urlFoto'];

  Map<String, dynamic> toJson() => {"username": username, "urlFoto": urlFoto};
}
