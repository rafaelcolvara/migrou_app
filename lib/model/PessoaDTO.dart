import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class PessoaDTO {

  int id;
  String nome;
  String email;
  String senha;  
  DateTime dataCadastro;
  DateTime dataNascimento;

  PessoaDTO(int id, this.nome, this.dataNascimento, this.dataCadastro, this.email, this.senha);

  PessoaDTO.fromJson(Map<String, dynamic> json):
    id = json['id'],
    nome = json['nome'],
    email = json['email'],
    dataNascimento = new DateFormat().add_yMd().parse(json['dataNascimento']),
    dataCadastro = new DateFormat().add_yMd().parse(json['dataCadastro']),
    senha = json['senha'];
  
    Map<String, dynamic> toJson() => {
        'id' :id,
        'nome': nome,
        'email' : email,
        'dataNascimento' : DateFormat().add_yMd().format(dataCadastro),
        'dataCadastro' : DateFormat().add_yMd().format(dataCadastro),
        'senha'        : senha
    };

    String dataAniversarioFormatada () { 
    DateFormat dateFormat = DateFormat("dd/MM");
    return dateFormat.format(dataNascimento);
    
  }

    
}