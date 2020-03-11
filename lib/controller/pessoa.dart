import 'package:mobx/mobx.dart';
part 'pessoa.g.dart';

class Pessoa = _PessoaBase with _$Pessoa;
abstract class _PessoaBase with Store {
 
  @observable
  int idPessoa;

  @action
  changeId(int newId) => idPessoa = newId;

  @observable
  String nome;


  @action
  changeName(String newName) => nome = newName;

  @observable
  String base64Foto;

  @action
  changeFoto(String newBase64Foto) => base64Foto = newBase64Foto; 

  @observable
  String nrCelular;

  @action
  changeCelular(String newnrCelular) => nrCelular = newnrCelular; 


  @observable
  String email;

  @action
  changeEmail(String newEmail) => email = newEmail;

  @observable
  String cpf;
  
  @action
  changeCpf(String newCpf) => cpf = newCpf;

  @observable
  String senha;
  
  @action
  chageSenha(String newSenha) => senha = newSenha;

  @observable
  DateTime dataNascimento=DateTime.now();
  
  @action
  changeDataDascimento(DateTime newDataNascimento) => dataNascimento = newDataNascimento;

  @observable
  bool flgVendedor=false;

  @action
  changeVendedor(bool value)=> flgVendedor =value;

  
}