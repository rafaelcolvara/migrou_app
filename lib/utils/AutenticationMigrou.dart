import 'dart:async';

import 'package:migrou_app/http/webClients/PessoaWebClient.dart';
import 'package:migrou_app/model/PessoaDTO.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password, String tipoPessoa);

  Future<String> signUp(String email, String password);

  Future<PessoaDTO> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final PessoaWebClient webClient = new PessoaWebClient();
  PessoaDTO pessoaLogada = new PessoaDTO();
  
  Future<String> signIn(String email, String password, String tipoPessoa) async {
    PessoaDTO result =  await webClient.logaPorEmailSenha(email: email, senha: password, tipoPessoa: tipoPessoa );
    pessoaLogada = result;    
    return result==null?"":result.id;
  }

  Future<String> signUp(String email, String password) async {
    PessoaDTO result = await webClient.logaPorEmailSenha(email: email, senha: password);
    return result.id;
  }

  Future<PessoaDTO> getCurrentUser() async {
    return pessoaLogada;
  }

  Future<void> signOut() async {
    pessoaLogada = null;
    return null;
  }

  Future<void> sendEmailVerification() async {
    // todo
  }

  Future<bool> isEmailVerified() async {

    if (pessoaLogada!=null){
      return pessoaLogada.flgEmailValido;
    }
    return false;
  }
}
