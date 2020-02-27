import 'package:migrou_app/model/pessoaDTO.dart';

class ContaCorrenteDTO {

  PessoaDTO pessoa;

  DateTime dtLancamento;

  double vlrLancamento;

  ContaCorrenteDTO(this.pessoa, this.dtLancamento, this.vlrLancamento);
  
}