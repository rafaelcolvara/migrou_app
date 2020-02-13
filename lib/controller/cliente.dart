import 'package:mobx/mobx.dart';
part 'cliente.g.dart';

class Cliente = _ClienteBase with _$Cliente;
abstract class _ClienteBase with Store {

  @observable
  String nome;

  @action
  changeName(String newName) => nome = newName;

  @observable
  String email;
  changeEmail(String newEmail) => email = newEmail;

  @observable
  String cpf;
  changeCpf(String newCpf) => cpf = newCpf;

  @observable
  bool flgVendedor=false;

  @action
  changeVendedor(bool value)=> flgVendedor =value;
}