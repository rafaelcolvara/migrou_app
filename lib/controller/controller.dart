import 'package:migrou_app/controller/pessoa.dart';
import 'package:mobx/mobx.dart';
import 'package:cpfcnpj/cpfcnpj.dart';

part 'controller.g.dart';

class Controller = _ControllerBase with _$Controller;

abstract class _ControllerBase with Store {
  var pessoa = Pessoa();

  @computed
  bool get isValid{
    return validaSenha() == null && validaEmail() == null && validaName() == null && validaData()==null;
  }

  String validaName() {
    if (pessoa.nome == null || pessoa.nome.isEmpty) {
      return "Nome precisa ser preenchido";
    } else if (pessoa.nome.length <= 4) {
      return "Seu nome precisa ter mais que 3 caracteres";
    }
    return null;
  }

  String validaEmail() {

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (pessoa.email == null || pessoa.email.isEmpty) {
      return "Informe um e-mail válido";
    } else if (!regex.hasMatch(pessoa.email) ) {
      return "E-mail inválido!";
    }
      return null;
    }

  String validaCpf() {

    if (pessoa.cpf == null || pessoa.cpf.isEmpty) {
      return "Este campo é obrigatório";
    } else if (pessoa.cpf.length<=11) {
        if (!CPF.isValid(pessoa.cpf)) {
            return "Cpf Inválido!";
        }
    }
      else if ((pessoa.cpf.length>11 && pessoa.cpf.length < 15) || (pessoa.cpf.length>15)) {
        if (!CNPJ.isValid(pessoa.cpf)){
          return "CNPJ Inválido!";
        }
    }
    return null;
  }
  String validaSenha() {

    if (pessoa.senha == null || pessoa.senha.isEmpty) {
      return "Crie uma senha";
    } else if (pessoa.senha.length<=2) {
        return "senha muito curta";        
    }
    return null;
  }

String validaData() {

    if (pessoa.dataNascimento == null) {
      return "Informa a data de nascimento";
    } else if (pessoa.dataNascimento.year < DateTime.now().year-12 ) {
        return "Você é muito novo";        
    }
    return null;
  }


  String nomeLabelSwith() {
    return pessoa.flgVendedor?"Vendedor":"Cliente";
  }


}
