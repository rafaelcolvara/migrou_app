import 'package:migrou_app/model/PessoaDTO.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class VendedorDTO {

  VendedorDTO({this.idVendedor, this.nomeNegocio, this.nomeSegmento, this.pessoaDTO});

	PessoaDTO pessoaDTO;
	
	String idVendedor;
	
	String nomeNegocio;
	
	String nomeSegmento;	

  VendedorDTO.fromJson(Map<String, dynamic> json):
    idVendedor = json['idVendedor'],
    pessoaDTO = PessoaDTO.fromJson(json['pessoaDTO']),
    nomeNegocio = json['nomeNegocio'],
    nomeSegmento = json['nomeSegmento'];
  
    Map<String, dynamic> toJson() => {
        'idVendedor' :idVendedor,
        'pessoaDTO': pessoaDTO,
        'nomeNegocio'   : nomeNegocio,
        'nomeSegmento' : nomeSegmento
    };

 
}