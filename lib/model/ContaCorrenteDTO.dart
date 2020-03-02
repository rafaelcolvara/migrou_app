import 'package:migrou_app/model/pessoaDTO.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class ContaCorrenteDTO {

  PessoaDTO pessoa;

  DateTime dtLancamento;

  double vlrLancamento;

  ContaCorrenteDTO(this.pessoa, this.dtLancamento, this.vlrLancamento);
  
}