class LancarCreditoDTO {
  Clientes clientes;

  LancarCreditoDTO({this.clientes});

  LancarCreditoDTO.fromJson(Map<String, dynamic> json) {
    clientes = json['clientes'] != null
        ? new Clientes.fromJson(json['clientes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clientes != null) {
      data['clientes'] = this.clientes.toJson();
    }
    return data;
  }
}

class Clientes {
  String username;
  int idCampanha;
  String nome;
  int cpfCnpj;
  String dataCadastro;
  bool flgEmailValido;
  String tipoPessoa;
  String urlFoto;
  String nrCelular;

  Clientes(
      {this.username,
      this.urlFoto,
      this.idCampanha,
      this.nrCelular,
      this.nome,
      this.cpfCnpj,
      this.dataCadastro,
      this.flgEmailValido,
      this.tipoPessoa});

  Clientes.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    idCampanha = json['idCampanha'];
    nome = json['nome'];
    cpfCnpj = json['cpfCnpj'];
    dataCadastro = json['dataCadastro'];
    flgEmailValido = json['flgEmailValido'];
    tipoPessoa = json['tipoPessoa'];
    urlFoto = json['urlFoto'];
    nrCelular = json['nrCelular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['idCampanha'] = this.idCampanha;
    data['nome'] = this.nome;
    data['cpfCnpj'] = this.cpfCnpj;
    data['dataCadastro'] = this.dataCadastro;
    data['flgEmailValido'] = this.flgEmailValido;
    data['tipoPessoa'] = this.tipoPessoa;
    data['urlFoto'] = this.urlFoto;
    data['nrCelular'] = this.nrCelular;
    return data;
  }
}
