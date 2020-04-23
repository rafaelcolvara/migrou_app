import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class PessoaSimplificadaDTO {

  String idPessoa;
  String nome;  
  String email;
  
  PessoaSimplificadaDTO(int idPessoa, this.nome, this.email);

  PessoaSimplificadaDTO.fromJson(Map<String, dynamic> json):
    idPessoa = json['id'],
    nome = json['nome'],
    email = json['email'] ;
  
    Map<String, dynamic> toJson() => {
        'id' :idPessoa,
        'nome': nome,
        'email' : email        
    };
    
  }
