import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class PessoaFotoDTO {
  String idPessoa;
  String base64Foto;

  PessoaFotoDTO({this.idPessoa, this.base64Foto});

  PessoaFotoDTO.fromJson(Map<String, dynamic> json)
      : idPessoa = json['idPessoa'],
        base64Foto = json['base64Foto'];

  Map<String, dynamic> toJson() =>
      {"idPessoa": idPessoa, "base64Foto": base64Foto};
}
