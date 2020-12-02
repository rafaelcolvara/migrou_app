class DataResgates {
  String idCliente;
  String nomeCliente;
  String idVendedor;
  double vlrUltimoResgate;
  String dataUltimoResgate;

  DataResgates(
      {this.idCliente,
      this.nomeCliente,
      this.idVendedor,
      this.vlrUltimoResgate,
      this.dataUltimoResgate});

  DataResgates.fromJson(Map<String, dynamic> json) {
    idCliente = json['idCliente'];
    nomeCliente = json['nomeCliente'];
    idVendedor = json['idVendedor'];
    vlrUltimoResgate =
        json['vlrUltimoResgate'] == null || json['vlrUltimoResgate'] == 0
            ? 0.00
            : json['vlrUltimoResgate'];
    dataUltimoResgate = json['dataUltimoResgate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCliente'] = this.idCliente;
    data['nomeCliente'] = this.nomeCliente;
    data['idVendedor'] = this.idVendedor;
    data['vlrUltimoResgate'] = this.vlrUltimoResgate;
    data['dataUltimoResgate'] = this.dataUltimoResgate;
    return data;
  }
}
