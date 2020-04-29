import 'package:migrou_app/model/PessoaDTO.dart';

class VendedorDTO {

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