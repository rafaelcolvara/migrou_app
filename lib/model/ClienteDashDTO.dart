import 'package:intl/intl.dart';
import 'package:migrou_app/model/CampanhaDTO.dart';
import 'package:migrou_app/model/VendedorDTO.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class ClienteDashDTO {
  ClienteDashDTO(this.vendedor, this.dtUltimaCompra, this.vlrComprasRealizadas,
      this.qtdComprasRealizadas, this.vlrCashBack);

  VendedorDTO vendedor;

  DateTime dtUltimaCompra;

  double vlrComprasRealizadas;

  int qtdComprasRealizadas;

  double vlrCashBack;

  CampanhaDTO campanha;

  ClienteDashDTO.fromJson(Map<String, dynamic> json)
      : vendedor = VendedorDTO.fromJson(json['vendedorDTO']),
        dtUltimaCompra = new DateFormat('dd/MM/yyyy').parse(
            json.containsKey('dtUltimaCompra')
                ? json['dtUltimaCompra']
                : '01/01/1900'),
        vlrComprasRealizadas = json['vlrComprasRealizadas'] == 0
            ? double.parse('0')
            : double.parse(json['vlrComprasRealizadas'].toString()),
        vlrCashBack = json['valorCashBack'],
        qtdComprasRealizadas = json['qtdComprasRealizadas'],
        campanha = CampanhaDTO.fromJson(json['campanhaDTO']);

  Map<String, dynamic> toJson() => {
        'vendedor': vendedor,
        'dtUltimaCompra': DateFormat('dd/MM/yyyy').format(dtUltimaCompra),
        'vlrComprasRealizadas': vlrComprasRealizadas,
        'vlrCashBack': vlrCashBack,
        'qtdComprasRealizadas': qtdComprasRealizadas
      };
}
