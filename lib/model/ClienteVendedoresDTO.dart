import 'package:migrou_app/model/ClienteDTO.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:migrou_app/model/VendedorDTO.dart';


@JsonSerializable(nullable: false)
class ClienteVendedoresDTO{

    ClienteVendedoresDTO({this.cliente, this.vendedores});

    ClienteDTO cliente;

    List<VendedorDTO> vendedores;


  static ClienteVendedoresDTO fromJson(Map<String, dynamic> json)
  {
    ClienteVendedoresDTO retorno = ClienteVendedoresDTO();
    List<VendedorDTO> listVendedores = List<VendedorDTO>();
    retorno.cliente = ClienteDTO.fromJson(json['cliente']) ;
    List<dynamic> t1 = json['vendedores'];
    t1.forEach((element) {
      VendedorDTO teste = VendedorDTO.fromJson(element);
      try{
        listVendedores.add(teste);
      }catch(e){
        print(e.toString());
      }
      retorno.vendedores = listVendedores;

     });
  
    return retorno;

  }
    
    
    Map<String, dynamic> toJson() => {
        'cliente' :cliente,
        'vendedores': vendedores
    };

}
