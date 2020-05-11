import 'package:migrou_app/model/PessoaDTO.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class ClienteDTO {

  ClienteDTO({this.idCampanha, this.idCliente, this.pessoaDTO});
  
  String idCliente;

  int idCampanha;

  PessoaDTO pessoaDTO;

  ClienteDTO.fromJson(Map<String, dynamic> json):
    idCliente  = json['idCliente'],
    idCampanha = json.containsKey('idCampanha')?json['idCampanha']:0,
    pessoaDTO  = json.containsKey('pessoaDTO')?PessoaDTO.fromJson(json['pessoaDTO']):new PessoaDTO();
  
    Map<String, dynamic> toJson() => {
        'idCliente' :idCliente,
        'idCampanha' : idCampanha,        
        'pessoaDTO'   : pessoaDTO
    };
}