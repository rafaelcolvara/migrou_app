import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class PessoaDTO {
  String id;
  String nome;
  String email;
  String senha;
  DateTime dataCadastro;
  DateTime dataNascimento;
  String nrCelular;
  String base64Foto;
  bool flgEmailValido;
  String tipoPessoa;
  String token;

  PessoaDTO(
      {int id,
      this.nome,
      this.dataNascimento,
      this.dataCadastro,
      this.email,
      this.senha,
      this.nrCelular,
      this.base64Foto,
      this.flgEmailValido,
      this.tipoPessoa,
      this.token});

  PessoaDTO.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'],
        email = json['email'],
        dataNascimento = new DateFormat('dd/MM/yyyy').parse(
            json.containsKey('dataNascimento')
                ? json['dataNascimento']
                : '01/01/1900'),
        dataCadastro = new DateFormat('dd/MM/yyyy').parse(
            json.containsKey('dataCadastro')
                ? json['dataCadastro']
                : '01/01/1900'),
        senha = json['senha'],
        nrCelular = json.containsKey('nrCelular') ? json['nrCelular'] : '',
        base64Foto = json.containsKey('base64Foto') ? json['base64Foto'] : '',
        flgEmailValido =
            json.containsKey('flgEmailValido') ? json['flgEmailValido'] : false,
        tipoPessoa = json.containsKey('tipoPessoa') ? json['tipoPessoa'] : '',
        token = json.containsKey('token') ? json['token'] : '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'email': email,
        'dataNascimento': DateFormat('dd/MM/yyyy').format(dataCadastro),
        'dataCadastro': DateFormat('dd/MM/yyyy').format(dataCadastro),
        'senha': senha,
        'nrCelular': nrCelular,
        'base64Foto': base64Foto,
        'flgEmailValido': flgEmailValido,
        'tipoPessoa': tipoPessoa,
        'token': token
      };

  String dataAniversarioFormatada() {
    DateFormat dateFormat = DateFormat("dd/MM");
    return dateFormat.format(dataNascimento);
  }
}
