import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class   PessoaDTO {

  int id;

  String nome;

  String email;

  String senha;
  
  DateTime dataCadastro;

  DateTime dataNascimento;


  PessoaDTO(int id, this.nome, this.dataNascimento, this.dataCadastro, this.email, this.senha);

  PessoaDTO.fromJson(Map<String, dynamic> json):
    nome = json['nome'],
    id = json['id'],
    email = json['email'],
    dataNascimento = new DateFormat().add_yMd().parse(json['dataNascimento']),
    dataCadastro = new DateFormat().add_yMd().parse(json['dataCadastro']),
    senha = json['senha'];
  
    Map<String, dynamic> toJson() => {
        'nome': nome,
        'id' :id,
        'email' : email,
        'dataNascimento' : DateFormat().add_yMd().format(dataCadastro),
        'dataCadastro' : DateFormat().add_yMd().format(dataCadastro),
        'senha'        : senha
    };
}