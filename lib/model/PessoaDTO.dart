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
  String nrCelular;
  String base64Foto;
  bool flgEmailValido;

  PessoaDTO({int id, this.nome, this.dataNascimento, this.dataCadastro, this.email, this.senha, this.nrCelular, this.base64Foto, this.flgEmailValido});

  PessoaDTO.fromJson(Map<String, dynamic> json):
    id = json['id'],
    nome = json['nome'],
    email = json['email'],
    dataNascimento = new DateFormat().add_yMd().parse(json.containsKey('dataNascimento')?json['dataNascimento']:'01/01/2020'),
    dataCadastro = new DateFormat().add_yMd().parse(json.containsKey('dataCadastro')?json['dataCadastro']:'01/01/2020'),
    senha = json['senha'],
    nrCelular = json.containsKey('nrCelular')?json['nrCelular']:'',
    base64Foto = json.containsKey('base64Foto')?json['base64Foto']:'',
    flgEmailValido = json.containsKey('flgEmailValido')?json['flgEmailValido']:false;
  
    Map<String, dynamic> toJson() => {
        'id' :id,
        'nome': nome,
        'email' : email,
        'dataNascimento' : DateFormat().add_yMd().format(dataCadastro),
        'dataCadastro' : DateFormat().add_yMd().format(dataCadastro),
        'senha'        : senha,
        'nrCelular'    : nrCelular,
        'base64Foto'   : base64Foto,
        'flgEmailValido' : flgEmailValido
    };

    String dataAniversarioFormatada () { 
    DateFormat dateFormat = DateFormat("dd/MM");
    return dateFormat.format(dataNascimento);
    
  }

    
}