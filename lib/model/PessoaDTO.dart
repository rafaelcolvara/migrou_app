import 'package:intl/intl.dart';

class   PessoaDTO {

  int id;

  String nome;

  String email;

  String cpfCnpj;

  DateTime dataCadastro;

  List<String> tipoPessoa;

  PessoaDTO(this.id, this.nome, this.cpfCnpj, this.dataCadastro, this.email);

  PessoaDTO.fromJson(Map<String, dynamic> json):
    nome = json['nome'],
    id = json['id'],
    email = json['email'],
    cpfCnpj = json['cpfcnpj'],
    dataCadastro = new DateFormat().add_yMd().parse(json['dataCadastro']) ,
    tipoPessoa = new List<String>.from(json['tipoPessoa']);

    Map<String, dynamic> toJson() => {
        'nome': nome,
        'id' :id,
        'email' : email,
        'cpfcnpj' : cpfCnpj,
        'dataCadastro' : dataCadastro,
        'tipoPessoa' : tipoPessoa
    };
}