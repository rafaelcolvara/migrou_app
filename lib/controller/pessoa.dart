import 'package:mobx/mobx.dart';
part 'pessoa.g.dart';

class Pessoa = _PessoaBase with _$Pessoa;
abstract class _PessoaBase with Store {
 
  @observable
  String nome;

  @action
  changeName(String newName) => nome = newName;

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