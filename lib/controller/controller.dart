import 'package:migrou_app/controller/cliente.dart';
import 'package:mobx/mobx.dart';
import 'package:cpfcnpj/cpfcnpj.dart';

part 'controller.g.dart';

class Controller = _ControllerBase with _$Controller;

abstract class _ControllerBase with Store {
  var cliente = Cliente();

  @computed
  bool get isValid{
    return validaCpf() == null && validaEmail() == null && validaName() == null;
  }

  String validaName() {
    if (cliente.nome == null || cliente.nome.isEmpty) {
      return "Este campo é obrigatório";
    } else if (cliente.nome.length <= 3) {
      return "Seu nome precisa ter mais que 3 caracteres";
    }
    return null;
  }

  String validaEmail() {

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (cliente.email == null || cliente.email.isEmpty) {
      return "Este campo é obrigatório";
    } else if (!regex.hasMatch(cliente.email) ) {
      return "email inválido";
    }
      return null;
    }

  String validaCpf() {

    if (cliente.cpf == null || cliente.cpf.isEmpty) {
      return "Este campo é obrigatório";
    } else if (cliente.cpf.length<=11) {
        if (!CPF.isValid(cliente.cpf)) {
            return "Cpf Inválido!";
        }
    }
      else if ((cliente.cpf.length>11 && cliente.cpf.length < 15) || (cliente.cpf.length>15)) {
        if (!CNPJ.isValid(cliente.cpf)){
          return "CNPJ Inválido!";
        }
    }
    return null;
  }

  String nomeLabelSwith() {
    return cliente.flgVendedor?"Vendedor":"Cliente";
  }


}
