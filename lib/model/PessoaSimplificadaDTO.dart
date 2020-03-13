import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class PessoaSimplificadaDTO {

  int id;
  String nome;  
  String email;
  
  PessoaSimplificadaDTO(int id, this.nome, this.email);

  PessoaSimplificadaDTO.fromJson(Map<String, dynamic> json):
    id = json['id'],
    nome = json['nome'],
    email = json['email'] ;
  
    Map<String, dynamic> toJson() => {
        'id' :id,
        'nome': nome,
        'email' : email        
    };
    
  }
